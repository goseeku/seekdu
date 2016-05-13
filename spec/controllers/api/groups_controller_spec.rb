require 'rails_helper'

RSpec.describe Api::GroupsController, type: :controller do
	let(:my_group) { create(:group) }
	let(:my_user) { create(:user) }
	let(:other_user) { create(:user) }
	# let(:my_grouping) { create(:grouping, group: my_group, user: my_user) }
	# let(:other_grouping) { create(:grouping, group: my_group, user: other_user) }

	context "unauthorized user" do
		describe "GET index" do
			before { get :index }

			it 'returns http unauthorized' do
				expect(response).to have_http_status(401)
			end
		end

		describe "GET show" do
			before { get :show, id: my_group.id }
			it 'returns http unauthorized' do
				expect(response).to have_http_status(401)
			end
		end

		describe "POST create" do
			before { post :create }

			it 'returns http unauthorized' do
				expect(response).to have_http_status(401)
			end
		end

		describe "PUT update" do
			before { put :update, id: my_group.id }

			it 'returns http unauthorized' do
				expect(response).to have_http_status(401)
			end
		end

		describe "DELETE destroy" do
			before {delete :destroy, id: my_group.id }

			it 'returns http unauthorized' do
				expect(response).to have_http_status(401)
			end
		end
	end

	context "authorized user" do
		before { controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token) }

		describe "GET index" do
			before { get :index }

			it 'returns http success' do
				expect(response).to have_http_status(:success)
			end

			it 'returns json content type' do
				expect(response.content_type).to eq 'application/json'
			end
		end

		describe "GET show" do
			before { get :show, id: my_group.id }

			it 'returns http success' do
				expect(response).to have_http_status(:success)
			end

			it 'returns json content type' do
				expect(response.content_type).to eq 'application/json'
			end

			it 'returns the serialized group' do
				expect(response.body).to eq GroupSerializer.new(my_group).to_json
			end
		end

		describe "POST create" do
			before { 
				@new_group = build(:group, name: "New Group", id: 1)
				post :create, group: { name: @new_group.name, users: "#{my_user.id},#{other_user.id}" }
			}

			it 'returns http success' do
				expect(response).to have_http_status(:success)
			end

			it 'returns json content type' do
				expect(response.content_type).to eq 'application/json'
			end

			it 'creates a new group with the correct attributes' do
				expect(response.body).to eq GroupSerializer.new(@new_group).to_json
			end
		end

		describe "PUT update" do
			before {
				my_group.name = "New Group Name"
				third_user = create(:user)
				put :update, id: my_group.id, group: { name: my_group.name, users: "#{third_user.id}"}
			}

			it 'returns http success' do
				expect(response).to have_http_status(:success)
			end

			it 'returns json content type' do
				expect(response.content_type).to eq 'application/json'
			end

			it 'updates the group with the correct attributes' do
				puts response.body
				expect(response.body).to eq GroupSerializer.new(my_group).to_json
			end
		end

		describe "DELETE destroy" do
		end
	end
end