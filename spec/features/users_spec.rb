require 'spec_helper'

describe "Users" do
  let!(:user) { FactoryGirl.build(:user) }

  describe "when not logged in" do
    it "can sign up with valid info" do
      visit '/signup'

      fill_in 'Email', :with => 'jake@email.wm.edu'
      fill_in 'user_password', :with => 'foobar'
      fill_in 'user_password_confirmation', :with => 'foobar'

      click_button 'Create Account'

      page.should have_content 'Your account has been successfully created!'
    end

    it "cannot sign up with bad info" do
      visit '/signup'

      fill_in 'Email', :with => 'jake@email.wm.edu'
      fill_in 'user_password', :with => 'foobar'

      click_button 'Create Account'

      page.should have_content '2 errors prohibited your account from being created:'
    end
  end
end
