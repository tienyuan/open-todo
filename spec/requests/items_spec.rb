require 'rails_helper'

describe 'Items API' do

  context 'get /api/v1/lists/id' do
    before do
      @user = create(:user)
      @list = create(:list, permissions: 'open', user: @user)
      create_list(:item, 3, list_id: @list.id, completed: false)
      create(:item, list_id: @list.id, completed: true)
      get "/api/v1/lists/#{@list.id}", nil, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should show all incompleted items' do
      subject { json['list']['items'] }
      it { expect(response.status).to eq(200) }
      it { should be_a_kind_of(Array) }
      it { expect(subject.length).to eq(3) }
    end
  end

  context 'post /api/v1/lists/id/items' do
    before do
      @user = create(:user)
      @list = create(:list, user: @user)
      post "/api/v1/lists/#{@list.id}/items", { item: { description: 'test_item' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should create a new item' do
      it { expect(response.status).to eq(200) }
      it { expect(Item.last.description).to eq('test_item') }
    end
  end

  context 'patch /api/v1/lists/id/items' do
    before do
      @user = create(:user)
      @list = create(:list, user: @user)
      @item = create(:item, list_id: @list.id)
      patch "/api/v1/lists/#{@list.id}/items/#{@item.id}", { item: { description: 'test_item' } }, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should update an existing item' do
      it { expect(response.status).to eq(200) }
      it { expect(Item.last.description).to eq('test_item') }
    end
  end

  context 'delete /api/v1/items/id' do
    before do
      @user = create(:user)
      @list = create(:list, permissions: 'open', user: @user)
      @item = create(:item, list_id: @list.id, completed: 'false')
      delete "/api/v1/items/#{@item.id}", nil, 'X-ACCESS-TOKEN' => "#{@user.api_key.access_token}"
    end

    describe 'should mark item complete' do
      it { expect(response.status).to eq(200) }
      it { expect(Item.last.completed).to eq(true) }
    end
  end
end
