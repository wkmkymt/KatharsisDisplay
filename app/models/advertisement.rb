class Advertisement < ApplicationRecord
  # Validation
  validates :sponsor, presence: true, length: { maximum: 16 }
  validates :email, presence: true
  validates :adimg, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :placed_shop, presence: true
  validate :start_date_check
  validate :end_date_check

  # AdContract -> Shop
  has_many :ad_contract, dependent: :delete_all
  has_many :placed_shop, through: :ad_contract, source: :shop

  # Nest Create
  accepts_nested_attributes_for :ad_contract, allow_destroy: true

  private

    def start_date_check
      if self.start_date.present?
        if self.start_date < Date.today
          errors.add(:start_date, "に今日以降の日付を入力して下さい")
        end
      end
    end

    def end_date_check
      if self.start_date.present? and self.end_date.present?
        if self.start_date > self.end_date
          errors.add(:end_date, "に開始日以降の日付を入力して下さい")
        end
      end
    end
end
