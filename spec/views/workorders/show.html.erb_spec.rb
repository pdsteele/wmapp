require 'spec_helper'

describe "workorders/show" do
  before(:each) do
    @workorder = assign(:workorder, stub_model(Workorder,
      :description => "Description",
      :building => "Building",
      :room => "Room",
      :worker => "Worker",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/Building/)
    rendered.should match(/Room/)
    rendered.should match(/Worker/)
    rendered.should match(/State/)
  end
end
