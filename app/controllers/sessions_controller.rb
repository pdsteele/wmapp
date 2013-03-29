class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password]) #find_by_email(params[:session][:email].downcase)
    if user  #&& user.authenticate(params[:session][:password])
      sign_in_ user
      redirect_back_or user
      flash[:success] = "You are now logged in!"
    else
      user = Worker.authenticate(params[:email], params[:password])
      if user #&& user.authenticate(params[:session][:password])
        sign_in_ user
        redirect_to root_url
        #self.current_user = user
        flash[:success] = "Welcome! Please check your queued work orders and remember to be friendly!"
        #redirect_to root_url

      else
        flash.now[:error] = "Invalid email or password. Please try again!"
        render :action => 'new'
      end
    end
  end



  def destroy
    sign_out_
    redirect_to root_url
  end

end
