class User < ApplicationRecord
  # Include
  include SnsAuthModule
  include ProfileUpdateModule

  # Rollify
  rolify

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2 twitter facebook]

  # Attribute
  attr_accessor :current_password
  attr_accessor :profimg_temp
  attr_accessor :create_by_sns

  enum  gender:  { man: 0, woman: 1, others: 2 }
  enum  personality: {
    noanswer: 0,
    INTJ_A: 1, INTJ_T: 2, INTP_A: 3, INTP_T: 4, ENTJ_A: 5, ENTJ_T: 6, ENTP_A: 7, ENTP_T: 8,
    INFJ_A: 9, INFJ_T: 10, INFP_A: 11, INFP_T: 12, ENFJ_A: 13, ENFJ_T: 14, ENFP_A: 15, ENFP_T: 16,
    ISTJ_A: 17, ISTJ_T: 18, ISFJ_A: 19, ISFJ_T: 20, ESTJ_A: 21, ESTJ_T: 22, ESFJ_A: 23, ESFJ_T: 24,
    ISTP_A: 25, ISTP_T: 26, ISFP_A: 27, ISFP_T: 28, ESTP_A: 29, ESTP_T: 30, ESFP_A: 31, ESFP_T: 32
  }

  # Validation
  validates :comment, length:{maximum: 40}
  validates :name, presence:true, length:{maximum: 24}
  validates :password, presence: { if: :current_password }

  # CheckinRecord -> Shop
  has_many :checkin_record, dependent: :delete_all
  has_many :checking_shop, through: :checkin_record, source: :shop

  # Interest -> Tag
  has_many :interest, dependent: :delete_all
  has_many :tag, through: :interest

  # Color
  belongs_to :color

  # My Shop
  belongs_to :shop, optional: true

  # SNS Credentials
  has_many :sns_credentials, dependent: :destroy

  # Has Password?
  def has_password?
    return encrypted_password.present?
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
      if not has_checkined_today? shop_id
        checkin_point = Shop.find(shop_id).checkin_point
        set_point checkin_point
      end

      checkin_record.create(user_id: self.id, shop_id: shop_id)
    end
  end

  # Check Out
  def checkout
    if check_in?
      get_checkin_record.checkout
    end
  end

  private

    # Set pecific points to user
    def set_point(point)
      self.point += point
      self.save
    end

    # Has already checkined today?
    def has_checkined_today?(shop_id)
      checkin_record.where(shop_id: shop_id, created_at: Date.today.all_day).present?
    end

    # Require Password?
    def password_required?
      super && !create_by_sns
    end
end
