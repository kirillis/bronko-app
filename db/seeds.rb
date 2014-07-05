# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create users
puts "seeding users"
User.create(
    :username => "kirillis",
    :email => "kirillis@mail.com",
    :password => 'pwdpwd',
    :password_confirmation => 'pwdpwd',
  )

5.times do
  f_name = Faker::Name.first_name;
  User.create(
      :username => f_name,
      :email => f_name + "@mail.com",
      :password => 'pwdpwd',
      :password_confirmation => 'pwdpwd',
    )     
end

# create dummy subs
puts "seeding subs"
5.times do |i|
  Sub.create(
      :name => Faker::Team.name,
      :description => Faker::Lorem.paragraph( Random.rand(2..5) ),
      :user_id => Random.rand(1..5),
      :visible => true,
      :user_id => 1
    )
end

# create dummy Posts
puts "seeding posts"
20.times do |i|
  title = Faker::Lorem.paragraph( Random.rand(2..5) )
  text = Faker::Lorem.paragraph( Random.rand(5..10) )
  Post.create(
      :title => title,
      :text => text,
      :link => "http://www.k-im.de",
      :visible => true,
      :sub_id => Random.rand(1..5),
      :user_id => Random.rand(1..5),
      :popmeter => Popmeter.create
    )
end