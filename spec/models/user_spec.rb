require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { create(:user) }

	it { should have_many(:projects) }
	# it { should have_many(:groups) }
	# it { should have_many(:groupings) }

	# shoulda tests for username
	it { should validate_presence_of(:username) }
	it { should validate_length_of(:username).is_at_least(3).is_at_most(16) }
	it { should validate_uniqueness_of(:username) }

	# shoulda tests for first_name
	it { should validate_presence_of(:first_name) }
	it { should validate_length_of(:first_name).is_at_least(2).is_at_most(20) }

	# shoulda tests for last_name
	it { should validate_presence_of(:last_name) }
	it { should validate_length_of(:last_name).is_at_least(2).is_at_most(20) }

	# shoulda tests for grad_year
	it { should validate_length_of(:grad_year).is_equal_to(4) }

	# shoulda tests for school
	it { should validate_length_of(:school).is_at_least(3).is_at_most(30) }

	# shoulda tests for phone_number
	it { should validate_length_of(:phone_number).is_equal_to(10) }

	# shoulda tests for avatar_url

	describe "attributes" do
		it "should respond to username" do
			expect(user).to respond_to(:username)
		end

		it "should respond to first_name" do
			expect(user).to respond_to(:first_name)
		end

		it "should respond to last_name" do
			expect(user).to respond_to(:last_name)
		end

		it "should respond to grad_year" do
			expect(user).to respond_to(:grad_year)
		end

		it "should respond to school" do
			expect(user).to respond_to(:school)
		end

		it "should respond to phone_number" do
			expect(user).to respond_to(:phone_number)
		end

		it "should respond to avatar_url" do
			expect(user).to respond_to(:avatar_url)
		end

		it "should respond to role" do
			expect(user).to respond_to(:role)
		end
	end

	# describe "#generate_auth_token" do
	# 	it "creates a token" do
	# 		expect(user.auth_token).to_not be_nil
	# 	end
	# end
end
