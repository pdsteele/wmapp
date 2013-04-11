# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workorder_relationship do
    worker_id 1
    workorder_id 1
  end
end
