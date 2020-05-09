# ==================================================
#  [23] Interest
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/23_interest.csv") do |row|
  Interest.seed do |s|
    s.user_id = row[0]
    s.tag_id = row[1]
  end
end