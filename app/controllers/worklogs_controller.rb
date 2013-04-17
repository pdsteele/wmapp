class WorklogsController < ApplicationController

    def new
        @worklog = Worklog.new
    end #end function 

    def create
        #@workorder = @worklog.workorder_id
        @workorder = Workorder.find(params[:workorder_id])
        @worklog = @workorder.worklog.new(params[:worklog])
        @worklog.name = current_user.name

        if (@worklog.save)
            flash[:success] = @worklog.description
            @workorder.state = @worklog.state
            @workorder.save
        end
        #render 'worker/show_assigned'
        redirect_to root_path
    end

    def index
        @worklog = Worklog.find(params[:id])
    end #end function 

    def update
        @worklog = Worklog.find(params[:id])
    end #end function

    def show 
        @worklog = Worklog.find(params[:id])
    end

    def edit
        @worklog = Worklog.find(params[:id])
    end #end function
end
