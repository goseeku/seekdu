class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :email, :username, :role, :avatar_url

  def full_name
  	object.full_name
  end
end
