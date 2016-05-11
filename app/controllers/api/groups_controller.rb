class Api::GroupsController < ApiController
	before_filter :authenticate_user

	def index
		groups = Group.all

		render json: groups, each_serializer: GroupSerializer, status: 200
	end

	def show
		group = Group.find(params[:id])

		render json: group
	end

	def create
		group = Group.new(group_params)

		if group.save
			render json: group
		else
			unprocessable_entry(group)
		end
	end

	def update
	end

	def destroy
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end