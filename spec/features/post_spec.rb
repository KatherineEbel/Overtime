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
end