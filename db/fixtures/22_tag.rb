# ==================================================
#  [22] Tag
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/22_tag.csv") do |row|
  Tag.seed do |s|
    s.name = row[0]
    s.category_id = row[1]
  end
end