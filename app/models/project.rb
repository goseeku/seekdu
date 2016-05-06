class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  belongs_to :group

  validates :name,
  					length: { minimum: 3, maximum: 50 },
  					uniqueness: { case_sensitive: false },
  					presence: true
end
