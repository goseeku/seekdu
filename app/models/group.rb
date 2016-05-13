class Group < ActiveRecord::Base
	has_many :groupings
	has_many :users, through: :groupings
	has_many :projects

	validates :name,
						length: { minimum: 1, maximum: 20 },
						uniqueness: { case_sensitive: false },
						presence: true
end
