# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worker do

    name "Joe Worker"
    email "joe@wm.edu"
    phone "555-555-5555"
    password "MyString"
    password_confirmation "MyString"

  end
end
