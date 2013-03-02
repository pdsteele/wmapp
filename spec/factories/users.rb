# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "jonstewart@email.wm.edu"
    password "dailyshow"
    password_confirmation "dailyshow"
  end
end
