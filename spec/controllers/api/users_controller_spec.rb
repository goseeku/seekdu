require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
	let (:stu_user) { create(:user) }
	let (:par_user) { create(:user, role: :par) }
	let (:edu_user) { create(:user, role: :edu) }
	let (:admin_user) { create(:user, role: :admin) }

	context "unauthenticated users" do
		describe "GET show" do
			it "returns http unauthenticated" do
				get :show, id: stu_user.id
				expect(response).to have_http_status(401)
			end
		end
	end

	context "authenticated users" do
		before do
			controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(admin_user.auth_token)
		end

		describe "GET show for a student" do
			before { get :show, id: stu_user.id }

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "returns json content type" do
				expect(response.content_type).to eq 'application/json'
			end

			it "returns the current user" do
				expect(StudentSerializer.new(stu_user).to_json).to eq response.body
			end
		end

		describe "GET show for a parent" do
			before { get :show, id: par_user.id }

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "returns json content type" do
				expect(response.content_type).to eq 'application/json'
			end

			it "returns the current user" do
				expect(response.body).to eq ParentSerializer.new(par_user).to_json
			end
		end

		describe "GET show for an educator" do
			before { get :show, id: edu_user.id }

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "returns json content type" do
				expect(response.content_type).to eq 'application/json'
			end

			it "returns the current user" do
				expect(EducatorSerializer.new(edu_user).to_json).to eq response.body
			end
		end

		describe "GET show for admin" do
			before { get :show, id: admin_user.id }

			it "returns http success" do
				expect(response).to have_http_status(:success)
			end

			it "returns json content type" do
				expect(response.content_type).to eq 'application/json'
			end

			it "returns the current user" do
				expect(UserSerializer.new(admin_user).to_json).to eq response.body
			end
		end
	end
end