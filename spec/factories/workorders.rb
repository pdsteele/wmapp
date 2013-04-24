# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workorder do

    # description "Everything's broken"
#     building    "Adair"
#     room        "54"
#     worker      "Someone"
#     state       "Somestate"
#     worklogs 

    description "Fix Janet's toilet"
    building "dinwiddie"
    room "201"
    state "Assigned"
    worker { FactoryGirl.build(:worker) }
    user {   FactoryGirl.build(:user) }
    #worklogs { [FactoryGirl.build(:worklog)] }

  end
  

  # factory :worklog do
#     state "Pending"
#     description "Worklog of Jenny's toilet"
#     fac_man_only false
#     unsolicited false
#     name "Steve"
#     workorder_id 1
#     workorder 
#   end

  
  
  
end
