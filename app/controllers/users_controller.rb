class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]


  def new
    @user = User.new
    @dorms = Buildings.all.map(&:name).sort
  end

  def create

    begin
      if current_user.admin?
        @user = User.new(params[:user])
        if @user.save
          flash[:success] = "Your account has been successfully created!"
          redirect_to admin_path 
        else
          flash[:failure] = "Failed to create account!"
        end
      end

    rescue
      @user = User.new(params[:user])
      if @user.save
        sign_in_ @user
        flash[:success] = "Your account has been successfully created!"
        #self.current_user = @user
        redirect_to @user
      else
        flash[:failure] = "Failed to create account!"
        render 'new'
      end
    end
  end

  def show
    #@user = User.find(params[:id])
    @workorders = current_user.workorders#.paginate(page: params[:page])
    store_location 
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in_ @user
      redirect_to @user
    else
      render 'edit'
    end
  end


# for ensuring a user is logged in before accessing their stuff
  private

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end

end
