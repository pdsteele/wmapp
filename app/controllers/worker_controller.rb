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
    
    if (!@worklog.nil? and @worklog.save)
      flash[:success] = "Update complete!"
      render 'show_assigned'
      #redirect_to :back #reloads page 
    #else
      #flash[:notice] = "Error occurred, please try again" 
      #redirect_to :back
    end

  end

  def show_in_progress
    @workorders = current_user.workorders.where(:state => "In Progress")

    if (!@worklog.nil? and @worklog.save)
      #flash[:success] = "Update complete!"
      redirect_to :back #reloads page
    else
      flash[:notice] = "Error occurred, please try again" 
      #redirect_to :back
    end
  end
  
  
  def show_deferral_form
  	@worker = current_user
  end
  
 
  def show_accepted_workorder
    flash[:success] = "You have accepted the following workorder!"
  	@workorder = Workorder.find(params[:workorder_id])
  	
  	# worker needs to have access to state attribute here, hence second argument of update_attributes
	  Workorder.find(params[:workorder_id]).update_attributes({:state => "In Progress"}, :as => :admin)  	
  end
  
  
  def show_deferred_workorder
  	flash[:notice] = "You have deferred the following workorder!"
  	@workorder = Workorder.find(params[:workorder_id])
	  #Workorder.find(params[:workorder_id]).update_attributes({:state => "Deferred"}, :as => :admin) 
  end
  

  private

      def correct_worker
        @worker = Worker.find(params[:id])
        redirect_to(root_path) unless current_user?(@worker)
      end


end
