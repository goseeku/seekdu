class ApiController < ApplicationController
	skip_before_action :verify_authenticity_token

	rescue_from ActiveRecord::RecordNotFound, with: :not_found
	rescue_from ActionController::ParameterMissing, with: :malformed_request

	def authenticate_user
		authenticate_or_request_with_http_token do |token, options|
			@current_user = User.find_by(auth_token: token)
		end
	end

	def malformed_request
		error(400, 'The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications')
	end

	def not_found
		error(404, 'Record not found')
	end

	def unprocessable_entity(record)
		error(422, record.errors.full_messages)
	end

	private

	def error(status, message = "Something went wrong")
		response = {
			response_type: "ERROR",
			message: message
		}

		render json: response.to_json, status: status
	end
end