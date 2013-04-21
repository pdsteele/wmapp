require 'spec_helper'

describe Worker do
 subject { FactoryGirl.build(:worker) }

 describe "validations" do
   it { should validate_presence_of(:email) }
   it { should validate_presence_of(:phone) }
   it { should validate_presence_of(:name) }
   it { should validate_confirmation_of(:password) }
   it { should validate_presence_of(:password_confirmation) }
   it { should have_many(:workorders) }
  end

end
