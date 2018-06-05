# frozen_string_literal: true

require 'rails_helper'

describe 'Approval' do

  before do
    @admin_user = FactoryBot.create :admin_user
    login_as @admin_user, scope: :user
  end

  describe 'edit' do

    before do
      @post = FactoryBot.create :post
    end

    it 'should have a status that can be edited on form' do
      visit edit_post_path @post
      choose 'approved'
      click_button 'Save'
      expect(@post.reload.status).to eq 'approved'
    end
  end
end