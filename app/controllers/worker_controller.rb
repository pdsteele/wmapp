class WorkerController < ApplicationController
  def new
    @worker = Worker.new
  end

  def create
    if current_user.admin?
      @worker = Worker.new(params[:worker])
    end
    if @worker.save
      flash[:success] = "Your account has been successfully created!"
      redirect_to admin_path 
    else
        #redirect_to signup_path
        #figure out a way to discriminate between error types?
        flash[:failure] = "Failed to create account!"
    end
  end

  def show
    @worker = Worker.find(params[:id])
  end
end
end
