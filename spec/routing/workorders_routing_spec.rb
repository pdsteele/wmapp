require "spec_helper"

describe WorkordersController do
  describe "routing" do

    it "routes to #index" do
      get("/workorders").should route_to("workorders#index")
    end

    it "routes to #new" do
      get("/workorders/new").should route_to("workorders#new")
    end

    it "routes to #show" do
      get("/workorders/1").should route_to("workorders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workorders/1/edit").should route_to("workorders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workorders").should route_to("workorders#create")
    end

    it "routes to #update" do
      put("/workorders/1").should route_to("workorders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workorders/1").should route_to("workorders#destroy", :id => "1")
    end

  end
end
