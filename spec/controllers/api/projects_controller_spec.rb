require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :controller do
	let(:my_user) { create(:user) }
	let(:my_project) { create(:project, user_id: my_user.id) }
	let(:my_group) { create(:group) }
	let(:group_project) { create(:project, group_id: my_group.id) }

	context "unauthenticated user" do
		describe "GET index" do
			it 'returns http unauthenticated' do
				get :index, user_id: my_user.id
				expect(response).to have_http_status(401)
			end
		end

		describe "GET show" do
			it 'returns http unauthenticated' do
				get :show, user_id: my_user.id, id: my_project.id
				expect(response).to have_http_status(401)
			end
		end

		describe "POST create" do
			it 'returns http unauthenticated' do
				post :create, user_id: my_user.id, project: { name: "New Project" }
				expect(response).to have_http_status(401)
			end
		end

		describe "PUT update" do
			it 'returns http unauthenticated' do
				put :update, user_id: my_user.id, id: my_project.id, project: { name: "Updated Project" }
				expect(response).to have_http_status(401)
			end
		end

		describe "DELETE destroy" do
			it 'returns http unauthenticated' do
				delete :destroy, user_id: my_user.id, id: my_project.id
				expect(response).to have_http_status(401)
			end
		end
	end

	context "authenticated user" do
		before do
			controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
		end

		context "project belongs to a user" do
			describe "GET index" do
				before { get :index, user_id: my_user.id }

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end
			end

			describe "GET show" do
				before { get :show, user_id: my_user.id, id: my_project.id }

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'returns the serialized project' do
					expect(response.body).to eq ProjectSerializer.new(my_project).to_json
				end
			end

			describe "POST create" do
				before do
					@new_project = build(:project, user_id: my_user.id, id: 1)
					post :create, user_id: my_user.id, project: { name: @new_project.name }
				end

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'creates a project with the correct attributes' do
					expect(response.body).to eq ProjectSerializer.new(@new_project).to_json
				end
			end

			describe "PUT update" do
				before do
					@updated_project = build(:project, user_id: my_user.id, id: my_project.id, name: "Updated project")
					put :update, user_id: my_user.id, id: my_project.id, project: { name: @updated_project.name }
				end

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'updates the project with the correct attributes' do
					expect(response.body).to eq ProjectSerializer.new(@updated_project).to_json
				end
			end

			describe "DELETE destroy" do
				before do
					delete :destroy, user_id: my_user.id, id: my_project.id
				end

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'returns the correct json sucess message' do
					expect(response.body).to eq({ message: "Project deleted.", status: 200 }.to_json)
				end
			end
		end

		context "project belongs to a group" do
			describe "GET index" do
				before { get :index, group_id: my_group.id }

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end
			end

			describe "GET show" do
				before { get :show, group_id: my_group.id, id: group_project.id }

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'returns the serialized project' do
					expect(response.body).to eq ProjectSerializer.new(group_project).to_json
				end
			end

			describe "POST create" do
				before {
					@new_project = build(:project, id: 1, name: "New Group Project")
					post :create, group_id: my_group.id, project: { name: @new_project.name }
				}

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'creates a project with the correct attributes' do
					expect(response.body).to eq ProjectSerializer.new(@new_project).to_json
				end
			end

			describe "PUT update" do
				before {
					@updated_project = build(:project, group_id: my_group.id, id: group_project.id, name: "Updated Group Project")
					put :update, group_id: my_group.id, id: group_project.id, project: { name: @updated_project.name }
				}

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'updates a project with the correct attributes' do
					expect(response.body).to eq ProjectSerializer.new(@updated_project).to_json
				end
			end

			describe "DELETE destroy" do
				before { delete :destroy, group_id: my_group.id, id: group_project.id }

				it 'returns http success' do
					expect(response).to have_http_status(:success)
				end

				it 'returns json content type' do
					expect(response.content_type).to eq 'application/json'
				end

				it 'returns the correct json message' do
					expect(response.body).to eq({ message: "Project deleted.", status: 200 }.to_json)
				end
			end
		end
	end
end