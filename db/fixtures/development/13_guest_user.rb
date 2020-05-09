# ==================================================
#  [13] Guest User
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/development/13_guest_user.csv") do |row|
  file = File.open("./app/assets/images/prof/" + row[9], "r")

  User.seed do |s|
    s.name = row[0]
    s.email = row[1]
    s.password = "password"
    s.organization = row[2]
    s.comment = row[3]
    s.gender = row[4].to_i
    s.birthday = row[5]
    s.color_id = row[6]
    s.personality = row[7].to_i
    s.shop_id = row[8]
    s.profimg = file.read
    s.confirmed_at = Time.now
  end

  User.last.add_role :guest
end