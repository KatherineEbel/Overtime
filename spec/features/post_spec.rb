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

  describe 'new' do
    it 'should have a link from the homepage' do
      visit root_path
      click_link 'new_post'
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
      click_button 'Save'
      expect(User.last.posts.last.rationale).to eq('User Association')
    end
  end

  describe 'edit' do
    before do
      @post = FactoryBot.create :post
    end
    it 'should be reached by clicking edit link on index page' do
      visit posts_path
      click_link "edit_#{@post.id}"
      expect(page.status_code).to eq 200
    end

    it 'should be able to be edited' do
      visit edit_post_path @post

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Edited content'
      click_button 'Save'
      expect(page).to have_content 'Edited content'
    end
  end

  describe 'delete' do
    it 'should be deleted' do
      @post = FactoryBot.create :post
      visit posts_path
      click_link "delete_#{@post.id}"
      expect(page.status_code).to eq 200
    end
  end
end