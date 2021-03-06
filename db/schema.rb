# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all


5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

25.times do |i|
  p = Project.create!(
    title: Faker::App.name,
    owner_id: User.all.sample.id,
    description: Faker::Lorem.paragraph,
    goal: rand(100000),
    start_date: Time.now.utc - rand(60).days,
    end_date: Time.now.utc + rand(30..60).days,
    category: ["Art", "Comics", "Crafts", "Dance", "Design", "Fashion", "Food", "Games", "Journalism", "Music", "Photography", "Publishing", "Technology", "Theater"].sample,
    image: ['1.jpg','2.jpg', '3.jpg','4.jpg', '5.jpg','6.jpg','7.jpg','8.jpg','9.jpg','10.jpg','11.jpg','12.jpg','13.jpg','14.jpg','15.png','16.jpg','17.png','18.png','19.png','20.png','21.png','22.png','23.jpg','24.jpg','25.png'][i]
    #photo: ,
  )


 5.times do
   p.rewards.create!(
     description: Faker::Superhero.power,
     dollar_amount: rand(100),
   )
 end
end

20.times do
  r = Reward.all.sample
  Pledge.create!(
    user: User.all.sample,
    reward: r,
    dollar_amount: r.dollar_amount + rand(10)
  )
end
