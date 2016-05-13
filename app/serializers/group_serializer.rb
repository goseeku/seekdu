class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :users

  def users
  	users = []
  	object.groupings.each do |grouping|
  		users << grouping.user
  	end
    users.uniq!
  	users.map! do |user|
  		{
  			id: user.id,
  			email: user.email,
  			username: user.username,
  			first_name: user.first_name,
  			last_name: user.last_name,
  			phone_number: user.phone_number
  		}
  	end
  end
end
