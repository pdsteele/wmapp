class WorkordersController < ApplicationController
  #before_filter :signed_in_user, only: [:create, :destroy]

  def index
    @user = User.find(params[:id])
    @workorder = current_user.workorders.build(params[:workorder])
    if @workorder.save
      flash[:success] = "workorder created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def create
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
  end
