# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

1000.times do
    Sale.create!(
        amount: rand(1990..9490),
        origin: Faker::Company.name,
        sale_date: Faker::Date.between(from: Date.new(2020,1,1), to: Date.today),
    )
end

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed|
    load seed }