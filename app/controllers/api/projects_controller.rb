class Api::ProjectsController < ApiController
	before_filter :authenticate_user

	def index
		if params[:user_id]
			projects = Project.where(user_id: params[:user_id])
		elsif params[:group_id]
			projects = Project.where(group_id: params[:group_id])
		end

		render json: projects, each_serializer: ProjectSerializer, status: 200
	end

	def show
		user = User.find(params[:user_id])
		project = user.projects.find(params[:id])

		render json: project
	end

	def create
		project = Project.new(project_params)

		if project.save
			render json: project
		else
			unprocessable_entity(list)
		end
	end

	def update
		user = User.find(params[:user_id])
		project = user.projects.find(params[:id])

		if project.update(project_params)
			render json: project
		else
			unprocessable_entity(project)
		end
	end

	def destroy
			user = User.find(params[:user_id])
			project = user.projects.find(params[:id])
		if project.destroy
			render json: { message: "Project deleted.", status: 200 }, status: 200
		else
			render json: { message: "There was an error processing your request. Please try again", status: 503 }, status: 503		
		end
	end

	private
	def project_params
		params.require(:project).permit(:name)
	end
end