require 'spec_helper'

describe Worklog do
  subject { FactoryGirl.build(:worklog) }

  describe "validations" do
    it { should belong_to(:workorder) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    its(:fac_man_only) { should eq(false) }
  end
end
