require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create :user
  end
  describe 'creation' do
    it 'should be able to create' do
      expect(@user).to be_valid
    end

    it 'should require first_name and last_name' do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  end

  describe 'custom name methods' do
    it 'should combine first and last name for full_name' do
      expect(@user.full_name).to eq 'SNOW, JON'
    end
  end
end
