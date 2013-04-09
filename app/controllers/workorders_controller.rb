class WorkordersController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: :destroy


  def new
  	@user = current_user
  	@current_user_building = @user[:dorm] # the use shouldn't have to enter their info for building and room
	@current_user_room     = @user[:room] # we will set these as defaults in the text fields by passing them to the partial

  	@workorder = Workorder.new
  end

  def index
    #@user = User.find(params[:id])
    @workorder = current_user.workorders.build(params[:workorder])
    if @workorder.save
      flash[:success] = "Workorder created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def create
    @user = current_user
    @current_user_building = @user[:dorm]
	@current_user_room     = @user[:room]
    # @workorder[:building] = @user[:building]
    #@workorder[:room]     = @user[:dorm]
    @workorder = current_user.workorders.build(params[:workorder])
    
    if @workorder.save
      flash[:success] = "Workorder created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    #@user = User.find(params[:id])
    @workorder.destroy
  end

  #private

    #def correct_user
     # @workorder = current_user.workorders.find_by_id(params[:id])
      #redirect_to root_url if @workorder.nil?
    #end
end