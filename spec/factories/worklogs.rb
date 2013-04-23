# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :worklog do
    state "Pending"
    description "Worklog of Jenny's toilet"
    fac_man_only false
    name "Steve"
    workorder_id 1
  end
end
