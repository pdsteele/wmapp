class WorkordersController < ApplicationController
  before_filter :access_control
  #before_filter :correct_user, only: :destroy


  def new
  	@user = current_user
  	@current_user_building = @user[:dorm] # the use shouldn't have to enter their info for building and room
	  @current_user_room   = @user[:room] # we will set these as defaults in the text fields by passing them to the partial

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
    @workorder = current_user.workorders.build(params[:workorder])
    
    if @workorder.save
      flash[:success] = "Workorder created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @workorder = current_user.workorders.find(params[:id])
    if @workorder.update_attributes(params[:workorder])
      flash[:success] = "Workorder updated"
      redirect_to @workorder
    else
      render 'edit'
    end
  end

  def show
    @workorder = Workorder.find(params[:id])
  end

  def edit
    @workorder = Workorder.find(params[:id])
  end

  def destroy
    #@user = User.find(params[:id])
    @workorder = Workorder.find(params[:id])
    @workorder.destroy
  end

  private

    def access_control
      if (current_user.nil? || !(current_user.class == User || current_user.class == Worker))
        redirect_to login_url, notice: "Please sign in."
      end
    end


     # @workorder = current_user.workorders.find_by_id(params[:id])
      #redirect_to root_url if @workorder.nil?
    #end
end