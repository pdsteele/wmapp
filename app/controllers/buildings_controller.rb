class BuildingsController < ApplicationController
  def new
    @building = Buildings.new
  end

  def create
    @building = Buildings.new(params[:building])
    if @building.save
      flash[:success] = "Building successfully added"
    else
        #figure out a way to discriminate between error types?
        flash[:failure] = "Is this a duplicate building?"
     # render :action => 'new'
    end
  end

  def show
    @building = Buildings.find(params[:id])
  end
end
