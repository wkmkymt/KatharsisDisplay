# ==================================================
#  [01] Color
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/01_color.csv") do |row|
  Color.seed do |s|
    s.name = row[0]
  end
end
