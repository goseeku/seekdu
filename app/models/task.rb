class Task < ActiveRecord::Base
  belongs_to :project
  has_many :subtasks

  validates :description, length: { minimum: 1, maximum: 300 }, presence: true
end
