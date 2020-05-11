class StartDateValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present?
      if record.start_date < Date.today
        record.errors.add(:start_date, "に今日以降の日付を入力して下さい")
      end
    end
  end
end