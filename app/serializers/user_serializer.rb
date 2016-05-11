class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :username, :role, :avatar_url, :groups

  def full_name
  	object.full_name
  end

  def groups
  	groups = []
  	object.groupings.each do |grouping|
  		groups << grouping.group unless groups.include?(grouping.group)
  	end

  	groups.map! do |group|
			{
				id: group.id,
				name: group.name
			}
  	end
  end

  def projects
		object.projects.map do |project|
			{
				id: project.id,
				name: project.name
			}
		end
	end
end
