# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worklog do
    state "MyString"
    description "MyString"
    fac_man_only false
    name "MyString"
    workorder_id 1
  end
end
