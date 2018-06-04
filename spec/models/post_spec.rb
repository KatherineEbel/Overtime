require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Creation' do
    before do
      @user = FactoryBot.build_stubbed :user
      @post = FactoryBot.build_stubbed :post
    end
    it 'should be created with required values' do
      expect(@post).to be_valid
    end

    it 'should validate date and rationale present' do
      @post.rationale = nil
      @post.date = nil
      expect(@post).to_not be_valid
    end
  end
end
