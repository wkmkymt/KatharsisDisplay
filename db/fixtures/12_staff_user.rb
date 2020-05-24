# ==================================================
#  [12] Staff User
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/12_staff_user.csv") do |row|
  User.seed do |s|
    s.name = row[0]
    s.email = row[1]
    s.password = "password"
    s.shop_id = row[2]
    s.confirmed_at = Time.now
  end

  User.last.add_role :staff
end