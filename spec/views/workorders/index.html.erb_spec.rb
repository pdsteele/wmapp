require 'spec_helper'

describe "workorders/index" do
  before(:each) do
    assign(:workorders, [
      stub_model(Workorder,
        :description => "Description",
        :building => "Building",
        :room => "Room",
        :worker => "Worker",
        :state => "State"
      ),
      stub_model(Workorder,
        :description => "Description",
        :building => "Building",
        :room => "Room",
        :worker => "Worker",
        :state => "State"
      )
    ])
  end

  it "renders a list of workorders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Building".to_s, :count => 2
    assert_select "tr>td", :text => "Room".to_s, :count => 2
    assert_select "tr>td", :text => "Worker".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
