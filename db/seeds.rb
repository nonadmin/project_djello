# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all

3.times do |i|
  User.create!(
    username: "Dixie#{i}",
    email: "test#{i}@example.com",
    password: "password",
    password_confirmation: "password")
end