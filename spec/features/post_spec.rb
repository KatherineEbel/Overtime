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
  end
end