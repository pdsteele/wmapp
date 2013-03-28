class UsersController < ApplicationController
  def new
    @user = User.new
    @grad_years = [2013, 2014, 2015, 2016]
    @dorms = Buildings.all.map(&:name)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Your account has been successfully created!"
      self.current_user = @user
      redirect_to @user
    else
        redirect_to signup_path
        #figure out a way to discriminate between error types?
        flash[:failure] = "Failed to create account! Did you enter your password correctly and use a WM email?"
     # render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
