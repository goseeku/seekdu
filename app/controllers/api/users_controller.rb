class Api::UsersController < ApiController
	before_filter :authenticate_user

	def show
		user = User.find(params[:id])

		case user.role
		when "stu"
			render json: user, serializer: StudentSerializer, status: 200
		when "par"
			render json: user, serializer: ParentSerializer, status: 200
		when "edu"
			render json: user, serializer: EducatorSerializer, status: 200
		else
			render json: user
		end
	end
end