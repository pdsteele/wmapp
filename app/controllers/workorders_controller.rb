class WorkordersController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: :destroy

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
    #@user = User.find(params[:id])
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
