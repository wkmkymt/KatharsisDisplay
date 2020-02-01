require "csv"

# User
CSV.foreach('db/seeds/users.csv') do |row|
  User.create(
    name: row[0],
    email: row[1],
    password: row[2],
  )
end

# Shop
CSV.foreach('db/seeds/shops.csv') do |row|
  Shop.create(
    name: row[0],
  )
end

# Tag
CSV.foreach('db/seeds/tags.csv') do |row|
  Tag.create(
    name: row[0],
  )
end

# Checkin
CSV.foreach('db/seeds/checkins.csv') do |row|
  Checkin.create(
    user_id: row[0],
    shop_id: row[1],
  )
end

# Interest
CSV.foreach('db/seeds/interests.csv') do |row|
  Interest.create(
    user_id: row[0],
    tag_id: row[1],
  )
end

# Review
CSV.foreach('db/seeds/reviews.csv') do |row|
  Review.create(
    reviewer_id: row[0],
    reviewed_id: row[1],
    rate: row[2],
    comment: row[3],
  )
end
