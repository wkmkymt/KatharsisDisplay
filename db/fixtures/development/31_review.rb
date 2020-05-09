# ==================================================
#  [31] Review
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/31_review.csv") do |row|
  Review.seed do |s|
    s.reviewer_id = row[0]
    s.reviewed_id = row[1]
    s.rate = row[2]
    s.comment = row[3]
  end
end