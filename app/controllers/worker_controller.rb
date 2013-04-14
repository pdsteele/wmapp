class WorkerController < ApplicationController
  before_filter :signed_in_worker, only: [:edit, :update, :show]
  before_filter :correct_worker,   only: [:edit, :update, :show]

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

  def edit
    #@worker = Worker.find(params[:id])
  end

  def show
    #@worker = Worker.find(params[:id])
      @workorders = @worker.workorders
  end

  def update
    #@worker = Worker.find(params[:id])
    if @worker.update_attributes(params[:worker])
      flash[:success] = "Profile updated"
      sign_in_ @worker
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show_assigned
    #@worker = Worker.find(params[:id])
    @workorders = current_user.workorders.where(:state => "Assigned")
  end

  def show_in_progress
    @workorders = current_user.workorders.where(:state => "In Progress")
  end

  private

      def correct_worker
        @worker = Worker.find(params[:id])
        redirect_to(root_path) unless current_user?(@worker)
      end


end
