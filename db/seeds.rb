require "csv"

# User
CSV.foreach("db/seeds/users.csv") do |row|
  user = User.create(
    name: row[0],
    email: row[1],
    password: "password",
  )
  user.add_role "guest"
end

# Admin User
admin = User.create(
  name: "admin",
  email: "admin@test.com",
  password: "password",
)
admin.add_role "admin"

# Shop
CSV.foreach("db/seeds/shops.csv") do |row|
  Shop.create(
    name: row[0],
  )
end

# Tag
CSV.foreach("db/seeds/tags.csv") do |row|
  Tag.create(
    name: row[0],
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

# Color
CSV.foreach("db/seeds/colors.csv") do |row|
  Color.create(
    name: row[0],
    user_id: row[1],
  )
end

# Photo
CSV.foreach("db/seeds/photos.csv") do |row|
  Photo.create(
    image: File.open("./app/assets/images/prof/" + row[0]),
    user_id: row[1],
  )
end