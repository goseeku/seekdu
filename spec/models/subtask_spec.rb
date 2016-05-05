require 'rails_helper'

RSpec.describe Subtask, type: :model do
  let(:subtask) { create(:subtask) }

	it { should belong_to(:task) }

	# shoulda tests for description
	it { should validate_presence_of(:description) }
	it { should validate_length_of(:description).is_at_least(1).is_at_most(300) }

	# shoulda tests for priority
	it { should validate_presence_of(:priority) }
	it { should validate_numericality_of(:priority).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5) }

	describe "attributes" do
		it "should respond to description" do
			expect(subtask).to respond_to(:description)
		end

		it "should respond to priority" do
			expect(subtask).to respond_to(:priority)
		end
	end
end
