require 'rails_helper'

describe 'Users API' do
  context 'get /api/v1/users/' do
    before do
      @user = create(:user)
      create_list(:user, 3)
      get '/api/v1/users/', nil, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should list all users' do
      it { expect(response.status).to eq(200) }
      it { expect(json['users']).to be_a_kind_of(Array) }
      it { expect(json['users'].length).to eq 4 }
    end
  end

  context 'post /api/v1/users/ with username and password' do
    before do
      @user = create(:user)
      post '/api/v1/users/', { user: { username: 'testuser', password: 'testpass' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should create a new user' do
      it { expect(response.status).to eq(200) }
      it { expect(json['user']).to eq('id' => User.last.id, 'username' => 'testuser') }
    end
  end

  context 'post /api/v1/users/ with nonunique username' do
    before do
      @user = create(:user)
      post '/api/v1/users/', { user: { username: 'testuser', password: 'testpass' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
      post '/api/v1/users/', { user: { username: 'testuser', password: 'testpass' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should fail' do
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to include('username') }
      it { expect(response.body).to include('taken') }
    end
  end

  context 'post /api/v1/users/ without a username' do
    before do
      @user = create(:user)
      post '/api/v1/users/', { user: { password: 'testpass' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should fail' do
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to include('username') }
      it { expect(response.body).to include('blank') }
    end
  end

  context 'post /api/v1/users/ without a password' do
    before do
      @user = create(:user)
      post '/api/v1/users/',
        { user: { username: 'testuser' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should fail' do
      it { expect(response.status).to eq(422) }
      it { expect(response.body).to include('password') }
      it { expect(response.body).to include('blank') }
    end
  end
end
