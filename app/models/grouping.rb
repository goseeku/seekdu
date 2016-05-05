class Grouping < ActiveRecord::Base
	belongs_to :groupable, polymorphic: true
end