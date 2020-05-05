class User < ApplicationRecord
  attr_accessor :profimg_temp

  # Attribute
  enum  gender:  { man: 0, woman: 1, others: 2 }
  enum  personality:  {noanswer: 0, INTJ_A: 1, INTJ_T: 2, INTP_A: 3, INTP_T: 4, ENTJ_A: 5, ENTJ_T: 6, ENTP_A: 7, ENTP_T: 8, INFJ_A: 9, INFJ_T: 10, INFP_A: 11, INFP_T: 12, ENFJ_A: 13, ENFJ_T: 14, ENFP_A: 15, ENFP_T: 16, ISTJ_A: 17, ISTJ_T: 18, ISFJ_A: 19, ISFJ_T: 20, ESTJ_A: 21, ESTJ_T: 22, ESFJ_A: 23, ESFJ_T: 24, ISTP_A: 25, ISTP_T: 26, ISFP_A: 27, ISFP_T: 28, ESTP_A: 29, ESTP_T: 30, ESFP_A: 31, ESFP_T: 32}

  PERSONALITY_SELECT_OPTIONS = [
    ['未診断の方は未回答', [
      ['未回答', 'noanswer']
    ]],
    ['分析家', [
      ['INTJ-A 建築家',   'INTJ_A'],
      ['INTJ-T 建築家', 'INTJ_T'],
      ['INTP-A 論理学者',    'INTP_A'],
      ['INTP-T 論理学者',   'INTP_T'],
      ['ENTJ-A 指揮官',   'ENTJ_A'],
      ['ENTJ-T 指揮官',   'ENTJ_T'],
      ['ENTP-A　討論者',   'ENTP_A'],
      ['ENTP-T　討論者',   'ENTP_T'],
    ]],
    ['外交官', [
      ['INFJ-A 提唱者',   'INFJ_A'],
      ['INFJ-T 提唱者',   'INFJ_T'],
      ['INFP-A 仲介者',   'INFP_A'],
      ['INFP-T 仲介者',   'INFP_T'],
      ['ENFJ-A 主人公',   'ENFJ_A'],
      ['ENFJ-T 主人公',   'ENFJ_T'],
      ['ENFP-A 広報運動家',   'ENFP_A'],
      ['ENFP-T 広報運動家',   'ENFP_T'],
    ]],
    ['番人', [
      ['ISTJ-A 管理者',   'ISTJ_A'],
      ['ISTJ-T 管理者',   'ISTJ_T'],
      ['ISFJ-A 擁護者',   'ISFJ_A'],
      ['ISFJ-T 擁護者',   'ISFJ_T'],
      ['ESTJ-A 幹部',   'ESTJ_A'],
      ['ESTJ-T 幹部',   'ESTJ_T'],
      ['ESFJ-A 領事官',   'ESFJ_A'],
      ['ESFJ-T 領事官',   'ESFJ_T'],
    ]],
    ['探検家', [
      ['ISTP-A 巨匠',   'ISTP_A'],
      ['ISTP-T 巨匠',   'ISTP_T'],
      ['ISFP-A 冒険家',   'ISFP_A'],
      ['ISFP-T 冒険家',   'ISFP_T'],
      ['ESTP-A 起業家',   'ESTP_A'],
      ['ESTP-T 起業家',   'ESTP_T'],
      ['ESFP-A エンターテイナー',   'ESFP_A'],
      ['ESFP-T エンターテイナー',   'ESFP_T'],
    ]]
  ]

  # Rollify
  rolify

  # CheckinRecord -> Shop
  has_many :checkin_record, dependent: :delete_all
  has_many :checking_shop, through: :checkin_record, source: :shop

  # Interest -> Tag
  has_many :interest, dependent: :delete_all
  has_many :tag, through: :interest

  # Reviewings
  has_many :reviewing_relationships, class_name:  "Review",
                                     foreign_key: "reviewer_id",
                                     dependent:   :destroy
  has_many :reviewings, through: :reviewing_relationships, source: :reviewed

  # Reviewers
  has_many :reviewer_relationships, class_name:  "Review",
                                    foreign_key: "reviewed_id",
                                    dependent:   :destroy
  has_many :reviewers, through: :reviewer_relationships, source: :reviewer

  # Color
  belongs_to :color

  # My Shop
  belongs_to :shop, optional: true

  # SNS Credentials
  has_many :sns_credentials, dependent: :destroy

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter facebook]

  # Config for Updating Profile
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # Find OAuth
  def self.find_oauth(auth)
    snscredential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first

    if snscredential.present?
      info = {
        user: with_sns_data(auth, snscredential),
        sns: snscredential,
      }
    else
      info = without_sns_data(auth)
    end

    return info
  end

  # Create with SNS Data
  def self.with_sns_data(auth, snscredential)
    user = User.find(snscredential.user_id).first

    unless user.present?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0,20],
      )
    end

    return user
  end

  # Create without SNS Data
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0,20],
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end

    return { user: user, sns: sns }
  end

  # Review
  def review(other_user, rate, comment: "")
    unless self == other_user
      reviewing_relationships.create(reviewed_id: other_user.id, rate: rate, comment: comment)
    end
  end

  # Unreview
  def unreview(other_user)
    reviewing_relationships.find_by(reviewed_id: other_user.id).destroy
  end

  # Is Reviewing?
  def reviewing?(other_user)
    reviewings.include?(other_user)
  end

  # Get Record Checked In
  def get_checkin_record
    checkin_record.where(check_in: 'in').first
  end

  # Get Shop Checked In
  def get_checkin_shop
    get_checkin_record.shop
  end

  # Check In?
  def check_in?
    get_checkin_record ? true : false
  end

  # Check In
  def checkin(shop_id)
    unless check_in?
      checkin_record.create(user_id: self.id, shop_id: shop_id)
      self.point += 1
      self.save
    end
  end

  # Check Out
  def checkout
    if check_in?
      get_checkin_record.checkout
    end
  end
end
