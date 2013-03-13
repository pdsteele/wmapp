class UsersController < ApplicationController
  def new
    @user = User.new
    @grad_years = [2013, 2014, 2015, 2016]
    @dorms = %w(Dinwiddie Stith Yates Monroe)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Your account has been successfully created!"
      self.current_user = @user
      redirect_to @user
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
