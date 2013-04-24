# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name "Example User"
    email "example@email.wm.edu"
    dorm "Adair"
    phone "18045678901"
    bannerID "930111222"
    room  "45"
    password "password"
    password_confirmation "password"
  end
end


