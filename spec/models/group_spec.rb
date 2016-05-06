require 'rails_helper'

RSpec.describe Group, type: :model do
	let(:group) { create(:group) }

  it { should have_many(:groupings) }
  it { should have_many(:users).through(:groupings) }
  it { should have_many(:projects) }

	# shoulda tests for name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1).is_at_most(20) }

  describe "attributes" do
  	it "should respond to name" do
  		expect(group).to respond_to(:name)
  	end
  end
end