require 'spec_helper'

describe "workorders/new" do
  before(:each) do
    assign(:workorder, stub_model(Workorder,
      :description => "MyString",
      :building => "MyString",
      :room => "MyString",
      :worker => "MyString",
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new workorder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workorders_path, "post" do
      assert_select "input#workorder_description[name=?]", "workorder[description]"
      assert_select "input#workorder_building[name=?]", "workorder[building]"
      assert_select "input#workorder_room[name=?]", "workorder[room]"
      assert_select "input#workorder_worker[name=?]", "workorder[worker]"
      assert_select "input#workorder_state[name=?]", "workorder[state]"
    end
  end
end
