class Subtask < ActiveRecord::Base
  belongs_to :task

  validates :description,
  					length: { minimum: 1, maximum: 300 },
  					presence: true

  validates :priority,
  					numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5},
  					presence: true
end
