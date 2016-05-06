require 'rails_helper'

RSpec.describe Grouping, type: :model do
	it { should belong_to(:user) }
	it { should belong_to(:group) }
end