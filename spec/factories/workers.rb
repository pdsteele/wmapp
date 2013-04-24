# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worker do
    name                  "Example"
    email                 "exampleuser1dsa7@wm.edu"
    phone                 "18045678901"
    password              "password"
    password_confirmation "password"
  end
end
