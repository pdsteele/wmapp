# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workorder do
    description "Everything's broken"
    building    "Adair"
    room        "54"
    worker      "Someone"
    state       "Somestate"
  end
end
