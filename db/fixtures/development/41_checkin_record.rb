# ==================================================
#  [41] Checkin Record
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/41_checkin_record.csv") do |row|
  CheckinRecord.seed do |s|
    s.user_id = row[0]
    s.shop_id = row[1]
    s.check_in = row[2]
  end
end