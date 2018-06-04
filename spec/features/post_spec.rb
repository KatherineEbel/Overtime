require 'rails_helper'
describe 'Post' do
  describe 'index' do
    it "should be reached successfully" do
      visit posts_path
      expect(page.status_code).to eq 200
    end

    it 'should have a title of Posts' do
      visit posts_path
      expect(page).to have_content('Posts')
    end
  end

  describe 'creation' do
    it 'should reach new form page' do
      visit new_post_path
      expect(page.status_code).to eq 200
    end

    it 'should create a new post with form' do
      user = User.create!(email: 'test2@test.com', password: 'password',
                          password_confirmation: 'password',
                          first_name: 'Jon', last_name: 'Snow')

      login_as(user, scope: :user)
      visit new_post_path
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Some rationale'
      click_on 'Save'
      expect(page).to have_content('Some rationale')
    end

    it 'should be associated to a user' do
      # TODO: Refactor
      user = User.create!(email: 'test3@test.com', password: 'password',
                          password_confirmation: 'password',
                          first_name: 'Jon', last_name: 'Snow')

      login_as(user, scope: :user)
      visit new_post_path
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User Association'
      click_on 'Save'
      expect(User.last.posts.last.rationale).to eq('User Association')
    end
  end

  after { Warden.test_reset! }
end