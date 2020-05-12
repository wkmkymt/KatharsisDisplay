module SnsAuthModule
  extend ActiveSupport::Concern

  class_methods do
    # Find OAuth
    def find_oauth(auth)
      new_flag = false
      sns = SnsCredential.find_or_initialize_by(uid: auth.uid, provider: auth.provider)

      if sns.persisted?
        user = User.find_or_initialize_by(id: sns.user_id)
      else
        user = User.find_or_initialize_by(email: auth.info.email)
      end

      if user.new_record?
        new_flag = true

        user.add_role :guest
        user.skip_confirmation!

        user.update_attributes({
          name: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0,20],
          profimg: get_sns_image(auth.info.image, auth.provider),
        })
      end

      if sns.new_record?
        sns.update_attributes({ user_id: user.id })
      end

      return { user: user, new: new_flag }
    end

    # Get SNS Image
    def get_sns_image(image, provider)
      require "open-uri"

      if provider == "twitter"
        image = image.gsub("_normal", "")
      elsif provider == "facebook"
        image = image.gsub("picture", "picture?type=large")
      end

      return open(image).read
    end
  end
end