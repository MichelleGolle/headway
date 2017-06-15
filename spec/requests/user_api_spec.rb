require 'rails_helper'

describe 'Retrieve user list from API', type: :request do
  context 'with token authentication via query params' do
    it 'returns status code 200' do
      user = create(:user, :admin)

      get admin_users_url(user_email: user.email,
                          user_token: user.authentication_token), as: :json

      expect(response.status).to eq 200
    end

    it 'returns valid user JSON matching schema' do
      user = create(:user, :admin)

      get admin_users_url(user_email: user.email,
                          user_token: user.authentication_token), as: :json

      expect(response).to match_response_schema('user')
    end
  end

  context 'with token authentication via request headers' do
    it 'returns status code 200' do
      user = create(:user, :admin)
      token_header_params = { 'X-User-Email': user.email,
                              'X-User-Token': user.authentication_token }

      get admin_users_url, headers: token_header_params, as: :json

      expect(response.status).to eq 200
    end
    it 'returns valid user JSON matching schema' do
      user = create(:user, :admin)
      token_header_params = { 'X-User-Email': user.email,
                              'X-User-Token': user.authentication_token }

      get admin_users_url, headers: token_header_params, as: :json

      expect(response).to match_response_schema('user')
    end
  end
end

describe 'Post user to API', type: :request do
  it 'creates a valid user matching schema' do
    user = create(:user, :admin)
    token_header_params = { 'X-User-Email': user.email,
                            'X-User-Token': user.authentication_token }
    user_params = { first_name: 'James',
                    email: 'james@test.com',
                    password: 'asdfjkl123',
                    password_confirmation: 'asdfjkl123' }

    post '/api/v1/users', headers: token_header_params,
                          params: { user: user_params },
                          as: :json

    user = User.last

    expect(response).to match_response_schema('user')
    expect(user.email).to eq(user_params[:email])
  end

  it 'returns status code 201' do
    user = create(:user, :admin)
    token_header_params = { 'X-User-Email': user.email,
                            'X-User-Token': user.authentication_token }
    user_params = { first_name: 'James',
                    email: 'james@test.com',
                    password: 'asdfjkl123',
                    password_confirmation: 'asdfjkl123' }

    post '/api/v1/users', headers: token_header_params,
                          params: { user: user_params },
                          as: :json

    expect(response.status).to eq 201
  end
end

describe 'PUT', type: :request do
  it 'updates user with response status 204' do
    user = create(:user, :admin)
    token_header_params = { 'X-User-Email': user.email,
                            'X-User-Token': user.authentication_token }
    id = create(:user).id
    user_params = { email: 'newadmin@test.com' }
    put "/api/v1/users/#{id}", headers: token_header_params,
                               params: { user: user_params },
                               as: :json
    user1 = User.find_by(id: id)

    expect(response.status).to eq 204
    expect(user1.email).to eq('newadmin@test.com')
  end
end
describe 'DELETE', type: :request do
  it 'destroys a user' do
    user = create(:user, :admin)
    token_header_params = { 'X-User-Email': user.email,
                            'X-User-Token': user.authentication_token }
    user1 = create(:user)

    expect(User.count).to eq(2)

    delete "/api/v1/users/#{user1.id}", headers: token_header_params

    expect(User.count).to eq(1)
    expect { User.find(user1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'returns response status 204' do
    user = create(:user, :admin)
    token_header_params = { 'X-User-Email': user.email,
                            'X-User-Token': user.authentication_token }
    user1 = create(:user)

    expect(User.count).to eq(2)

    delete "/api/v1/users/#{user1.id}", headers: token_header_params

    expect(response.status).to eq 204
  end
end
