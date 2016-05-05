class Group < ActiveRecord::Base
	has_many :groupings
	has_many :users, through: :groupings, source: :groupable, source_type: :User
	has_many :projects, through: :groupings, source: :groupable, source_type: :Project

	validates :name,
						length: { minimum: 1, maximum: 20 },
						presence: true
end
