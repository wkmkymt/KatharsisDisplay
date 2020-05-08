require "csv"

# Color
CSV.foreach("db/seeds/colors.csv") do |row|
  Color.create(
    name: row[0],
  )
end

# Shop
CSV.foreach("db/seeds/shops.csv") do |row|
  Shop.create(
    name: row[0],
    address: row[1],
    description: row[2],
    checkin_point: row[3],
  )
end

# Admin User
CSV.foreach("db/seeds/admin_users.csv") do |row|
  admin = User.new(
    name: row[0],
    email: row[1],
    password: "password",
  )
  admin.add_role "admin"
  admin.skip_confirmation!
  admin.save!
end

# Staff User
CSV.foreach("db/seeds/staff_users.csv") do |row|
  staff = User.new(
    name: row[0],
    email: row[1],
    password: "password",
    shop_id: row[2],
  )
  staff.add_role "staff"
  staff.skip_confirmation!
  staff.save!
end

# User
CSV.foreach("db/seeds/users.csv") do |row|
  file = File.open("./app/assets/images/prof/" + row[9], "r")

  user = User.new(
    name: row[0],
    email: row[1],
    password: "password",
    organization: row[2],
    comment: row[3],
    gender: row[4].to_i,
    birthday: row[5],
    color_id: row[6],
    personality: row[7].to_i,
    shop_id: row[8],
    profimg: file.read
  )
  user.add_role "guest"
  user.skip_confirmation!
  user.save!
end

# Category
CSV.foreach("db/seeds/categories.csv") do |row|
  Category.create(
    name: row[0],
  )
end

# Tag
CSV.foreach("db/seeds/tags.csv") do |row|
  Tag.create(
    name: row[0],
    category_id: row[1],
  )
end

# Checkin Record
CSV.foreach("db/seeds/checkin_records.csv") do |row|
  CheckinRecord.create(
    user_id: row[0],
    shop_id: row[1],
    check_in: row[2],
  )
end

# Interest
CSV.foreach("db/seeds/interests.csv") do |row|
  Interest.create(
    user_id: row[0],
    tag_id: row[1],
  )
end

# Review
CSV.foreach("db/seeds/reviews.csv") do |row|
  Review.create(
    reviewer_id: row[0],
    reviewed_id: row[1],
    rate: row[2],
    comment: row[3],
  )
end