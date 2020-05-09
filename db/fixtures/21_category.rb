# ==================================================
#  [21] Category
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/21_category.csv") do |row|
  Category.seed do |s|
    s.name = row[0]
  end
end