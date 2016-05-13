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
		build_groupings(group)

		if group.save
			render json: group
		else
			unprocessable_entity(group)
		end
	end

	def update
		group = Group.find(params[:id])

		group.groupings.each do |grouping|
			grouping.destroy
		end

		build_groupings(group)

		if group.update(group_params)
			render json: group
		else
			unprocessable_entity(group)
		end
	end

	def destroy
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end

	def build_groupings(group)
		users_array = params[:group][:users].split(',').uniq
		users_array.each do |a|
			group.groupings.build(user_id: a)
		end
	end
end