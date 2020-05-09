# ==================================================
#  [52] Ad Contract
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/52_ad_contract.csv") do |row|
  AdContract.seed do |s|
    s.advertisement_id = row[0]
    s.shop_id = row[1]
  end
end