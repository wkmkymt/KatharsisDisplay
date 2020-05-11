class EndDateValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? and record.end_date.present?
      if record.start_date > record.end_date
        record.errors.add(:end_date, "に開始日以降の日付を入力して下さい")
      end
    end
  end
end