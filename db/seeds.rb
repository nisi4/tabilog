# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: "test@test.com",
    password: "testtest"
)

require "csv"

CSV.foreach("db/towndata.csv") do |info|
    Town.create!(
        id: info[0],
        town_name: info[1]
    )
end
    
require "csv"

CSV.foreach("db/category_data.csv") do |row|
    Category.create!(
        id: row[0],
        category_name: row[1]
    )
end