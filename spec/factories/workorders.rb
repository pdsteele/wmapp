# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workorder do
    description "Fix Janet's toilet"
    building "dinwiddie"
    room "201"
    state "Assigned"
    worker { FactoryGirl.build(:worker) }
    user { FactoryGirl.build(:user) }
    worklogs { [FactoryGirl.build(:worklog)] }
  end
end
