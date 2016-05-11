# Create Users
5.times do
	User.create(
		username: Faker::Internet.user_name,
		email: Faker::Internet.email,
		password: 'password',
		first_name: 'user',
		last_name: 'user'
	)
end

User.create!(
	first_name: 'admin',
	last_name: 'admin',
	username: 'admin',
	role: :admin,
	email: 'admin@seeku.co',
	password: 'password'
)

users = User.all

# Create projects
20.times do
	Project.create(
		name: Faker::Lorem.sentence,
		user: users.sample	
	)
end

projects = Project.all

puts "Seed finished!"
puts "#{User.count} users created"
puts "#{Project.count} projects created"