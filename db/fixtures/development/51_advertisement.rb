# ==================================================
#  [51] Advertisement
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/51_advertisement.csv") do |row|
  file = File.open("./app/assets/images/ad/" + row[5], "r")

  Advertisement.seed do |s|
    s.sponsor = row[0]
    s.email = row[1]
    s.url = row[2]
    s.start_date = row[3]
    s.end_date = row[4]
    s.adimg = file.read
  end
end