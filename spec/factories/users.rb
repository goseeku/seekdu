FactoryGirl.define do
  factory :user, class: 'User' do
    email Faker::Internet.safe_email
    password 'password'
    password_confirmation 'password'
    username Faker::Internet.user_name
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    grad_year Faker::Number.between(2016, 2024)
    school Faker::University.name
    phone_number '0123456789'
    avatar_url Faker::Avatar.image
  end

end
