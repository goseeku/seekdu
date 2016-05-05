require 'rails_helper'

RSpec.describe Task, type: :model do
	let(:task) { create(:task) }

	it { should have_many(:subtasks) }
	it { should belong_to(:project) }

	# shoulda tests for description
	it { should validate_presence_of(:description) }
	it { should validate_length_of(:description).is_at_least(1).is_at_most(300) }

	describe "attributes" do
		it "should respond to description" do
			expect(task).to respond_to(:description)
		end

		it "should respond to due_date" do
			expect(task).to respond_to(:due_date)
		end

		it "should respond to start_date" do
			expect(task).to respond_to(:start_date)
		end
	end
end
