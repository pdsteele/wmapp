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
      store_location 
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
    @workorders = current_user.workorders.where(:state => ["Assigned", "Reopened"]) #also shows workorders that were resolved but reopened 
    store_location 
    
    if (!@worklog.nil? and @worklog.save)
      flash[:success] = "Update complete!"
      render 'show_assigned'
    else
      render 'show_assigned'
    end

  end

  def show_in_progress
    @workorders = current_user.workorders.where(:state => "In Progress")
    store_location 

    if (!@worklog.nil? and @worklog.save)
      flash[:success] = "Update complete!"
      render 'show_in_progress'
    else
      render 'show_in_progress'
    end
  end


  def completed_workorders

    @workorders = current_user.workorders.where(:state => "Closed")
    store_location

  end
  

  def message_center
    @urgent_worklogs = current_user.worklogs.where("created_at > ?", 7.days.ago).find(:all, :conditions => ['fac_man_only = ? or unsolicited = ?', true, true]) 
    @show_link = true 

    render 'message_center'
  end

  private

      def correct_worker
        @worker = Worker.find(params[:id])
        redirect_to(root_path) unless current_user?(@worker)
      end


end
