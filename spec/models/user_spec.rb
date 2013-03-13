require 'spec_helper'

describe User do

    subject { FactoryGirl.build(:user) }

    describe "validations" do
        it { should validate_presence_of(:email) }
        it { should validate_uniqueness_of(:email) }
        it { should validate_confirmation_of(:password) }
        it { should validate_presence_of(:password_confirmation) }
        it { should validate_presence_of(:dorm) }
        it { should validate_presence_of(:grad_year) }

        describe "graduating year" do
          it "should be a valid year" do
            (2013..2016).to_a.should include(:grad_year)
          end
        end

        context "when email format is valid" do
            valid_emails.each do |email|
                it { should allow_value(email).for(:email) }
            end
        end

        context "when email format is invalid" do
            invalid_emails.each do |email|
                it { should_not allow_value(email).for(:email) }
            end
        end
    end
    
end
