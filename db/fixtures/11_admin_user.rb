# ==================================================
#  [11] Admin User
# ==================================================

require "csv"

CSV.foreach("db/fixtures/csv/11_admin_user.csv") do |row|
  User.seed do |s|
    s.name = row[0]
    s.email = row[1]
    s.password = "password"
    s.confirmed_at = Time.now
  end

  User.last.add_role :admin
end
