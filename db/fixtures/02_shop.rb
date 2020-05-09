# ==================================================
#  [02] Shop
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/02_shop.csv") do |row|
  Shop.seed do |s|
    s.name = row[0]
    s.address = row[1]
    s.description = row[2]
    s.checkin_point = row[3]
  end
end
