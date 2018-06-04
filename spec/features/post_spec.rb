# frozen_string_literal: true

require 'rails_helper'

describe 'Post' do
  before do
    user = User.create!(email: 'post@test.com', password: 'password',
                        password_confirmation: 'password',
                        first_name: 'Jon', last_name: 'Snow')

    login_as(user, scope: :user)
  end
  describe 'index' do
    before do
      Post.create(date: Date.today, rationale: 'Post1')
      Post.create(date: Date.today, rationale: 'Post2')
      visit posts_path
    end
    it "should be reached successfully" do
      expect(page.status_code).to eq 200
    end

    it 'should have a title of Posts' do
      expect(page).to have_content('Posts')
    end

    it 'should have a list of posts' do
      expect(page).to have_content(/Post2|Post2/)
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