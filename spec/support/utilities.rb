
include ApplicationHelper

include Capybara::DSL # Adding this line solved the error

def log_in
  visit '/login'
  fill_in 'Email', :with => 'jonstewart@email.wm.edu'
  fill_in 'Password', :with => 'dailyshow'
  click_button 'Log in'
end

def valid_emails
  %w[jake@email.wm.edu jonstewart@email.wm.edu tj@email.wm.edu]
end

def invalid_emails
  %w[jake@gmail.com willsmith oldie@wm.edu]
end


def sign_in(user)

  visit '/login'

  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password

  click_button 'Log in'
  

  
  # Sign in when not using Capybara as well.
  #cookies[:remember_token] = user.remember_token
end
