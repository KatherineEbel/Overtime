# frozen_string_literal: true

require 'rails_helper'

describe 'Post' do
  before do
    @user = FactoryBot.create :user

    login_as(@user, scope: :user)
  end
  describe 'index' do
    before do
      FactoryBot.build_stubbed :post
      FactoryBot.build_stubbed :second_post
      visit posts_path
    end
    it "should be reached successfully" do
      expect(page.status_code).to eq 200
    end

    it 'should have a title of Posts' do
      expect(page).to have_content('Posts')
    end

    it 'should have a list of posts' do
      expect(page).to have_content(/Rationale|content/)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end
    it 'should reach new form page' do
      expect(page.status_code).to eq 200
    end

    it 'should create a new post with form' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      click_on 'Save'
      expect(page).to have_content('Some rationale')
    end

    it 'should be associated to a user' do
      # TODO: Refactor
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User Association'
      click_on 'Save'
      expect(User.last.posts.last.rationale).to eq('User Association')
    end
  end

  after { Warden.test_reset! }
end