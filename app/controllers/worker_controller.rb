class WorkerController < ApplicationController
  def new
    @worker = Worker.new
  end

  def create
    @worker = Worker.new(params[:worker])
    if @worker.save
      flash[:success] = "Your account has been successfully created!"
      self.current_user = @worker #not sure what this line does, but taken from user controller 
    else
        redirect_to signup_path
        #figure out a way to discriminate between error types?
        flash[:failure] = "Failed to create account! Did you enter your password correctly and use a WM email?"
    end
  end

  def show
    @worker = Worker.find(params[:id])
  end
end
end
