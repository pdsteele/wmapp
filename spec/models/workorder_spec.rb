require 'spec_helper'

describe Workorder do
  let(:workorder) { FactoryGirl.create(:workorder) }
  subject { FactoryGirl.build(:workorder) } 
  describe "validations" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:building) }
    it { should validate_presence_of(:room) }
    it { should belong_to(:user) }
    it { should belong_to(:worker) }
    it { should have_many(:worklogs) }
    its(:state) { should eq("Assigned") }
  end

end
