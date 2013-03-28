# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :building, :class => 'Buildings' do
    name "MyString"
  end
end
