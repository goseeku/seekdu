User.create!(
	first_name: 'admin',
	last_name: 'admin',
	username: 'admin',
	role: :admin,
	email: 'admin@seeku.co',
	password: 'password'
)

puts "Seed finished!"
puts "#{User.count} users created"