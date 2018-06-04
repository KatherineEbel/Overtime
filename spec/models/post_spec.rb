require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Creation' do
    before do
      @user = User.create!(email: 'post@test.com', password: 'password',
                           password_confirmation: 'password',
                           first_name: 'Jon', last_name: 'Snow')
      @post = Post.create(date: Date.today, rationale: 'Anything', user_id: @user.id)
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
