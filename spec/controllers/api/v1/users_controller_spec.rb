require 'rails_helper'

describe Api::V1::UsersController do

  before do
    @user = create(:user)
    auth_with_token(@user.api_key.access_token)
  end

  describe '#create' do
    it 'returns a new user from username and password params' do
      params = { user: { username: 'testuser', password: 'testpass' } }
      post :create, params
      last_user = User.last

      expect(response.status).to eq(200)
      expect(json).to eq('user' => { 'id' => last_user.id, 'username' => last_user.username })
      expect(User.last.username).to eq(last_user.username)
    end

    it 'returns an error when not given a password' do
      post :create, user: { username: 'testuser' }

      expect(response.status).to eq(422)
      expect(response.body).to include('password')
      expect(response.body).to include('blank')
    end

    it 'returns an error when not given a username' do
      post :create, user: { password: 'testpass' }

      expect(response.status).to eq(422)
      expect(response.body).to include('username')
      expect(response.body).to include('blank')
    end
  end

  describe '#index' do
    before do
      (2..4).each { |n| User.create(id: n, username: "name#{n}", password: "pass#{n}") }
    end

    it 'returns all usernames and ids' do
      get :index

      expect(response).to be_success
      expect(json).to eq(
        'users' =>
          [
            { 'id' => @user.id, 'username' => @user.username },
            { 'id' => 2, 'username' => 'name2' },
            { 'id' => 3, 'username' => 'name3' },
            { 'id' => 4, 'username' => 'name4' }
          ]
      )
    end
  end

  after do
    clear_token
  end
end
