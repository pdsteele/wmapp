class UsersController < ApplicationController
  def new
    @user = User.new
    @dorms = Buildings.all.map(&:name).sort

  end

  def create

    begin
    if current_user.admin?
      @user = User.new(params[:worker])
      if @worker.save
      flash[:success] = "Your account has been successfully created!"
      redirect_to admin_path 
      else
        #redirect_to signup_path
        #figure out a way to discriminate between error types?
        flash[:failure] = "Failed to create account! Did you enter your password correctly and use a WM email?"
      end
    end

    rescue
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Your account has been successfully created!"
        self.current_user = @user
        redirect_to @user
      else
        #redirect_to signup_path
        #figure out a way to discriminate between error types?
        flash[:failure] = "Failed to create account!"
        render 'new'
      end
    end


  end

  def show
    @user = User.find(params[:id])
  end
end
