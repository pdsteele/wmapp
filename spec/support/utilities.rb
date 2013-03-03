def log_in
  visit '/login'
  fill_in 'Email', :with => 'jonstewart@email.wm.edu'
  fill_in 'Password', :with => 'dailyshow'
  click_button 'Log in'
end
