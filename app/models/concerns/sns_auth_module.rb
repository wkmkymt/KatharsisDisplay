module SnsAuthModule
  extend ActiveSupport::Concern

  class_methods do
    # Find OAuth
    def find_oauth(auth)
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
    def with_sns_data(auth, snscredential)
      user = User.find(snscredential.user_id)

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
    def without_sns_data(auth)
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
  end
end