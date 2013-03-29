# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workorder do
    description "MyString"
    building "MyString"
    room "MyString"
    worker "MyString"
    state "MyString"
  end
end
