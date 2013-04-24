# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do

    email "jonstewart@email.wm.edu"
    name "jon stewart"
    dorm "Dinwiddie"
    phone "555-555-5555"
    bannerID "930555555"
    room "201"
    password "dailyshow"
    password_confirmation "dailyshow"

  end
end


