require 'rails_helper'

describe Item do
  before do
    @user = create(:user)
    @list = create(:list, user: @user)
    @item = create(:item, list_id: @list.id)
  end

  describe '#mark_complete' do
    it 'completes the item ' do
      expect(@item.mark_complete).to eq(true)
    end
  end

  describe '#incompleted scope' do
    it 'shows only incomplete items' do
      complete_item = create(:item, completed: true)
      expect(Item.all.incompleted).to include(@item)
      expect(Item.all.incompleted).not_to include(complete_item)
    end
  end

  describe 'ActiveModel validations' do
    it { should validate_inclusion_of(:completed).in_array([true, false]) }
  end

  describe 'ActiveRecord associations' do
    it { expect(@item).to belong_to(:list) }
  end
end
