require 'rails_helper'

RSpec.describe Project, type: :model do
	let(:project) { create(:project) }

	it { should belong_to(:user) }
	it { should have_many(:tasks) }

	# shoulda tests for name
	it { should validate_presence_of(:name) }
	it { should validate_length_of(:name).is_at_least(3).is_at_most(50) }
	it { should validate_uniqueness_of(:name) }

	describe "attributes" do
		it "should respond to name" do
			expect(project).to respond_to(:name)
		end
	end
end
