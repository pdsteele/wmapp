class WorklogsController < ApplicationController

    def new
        @worklog = Worklog.new
    end #end function 

    def create
        #@workorder = @worklog.workorder_id
        @workorder = Workorder.find(params[:workorder_id])
        @worklog = @workorder.worklog.new(params[:worklog])
        @worklog.name = current_user.name

        if (@worklog.state == "Deferred")
            @worklog.fac_man_only = true
        end

        if (@worklog.save)
            flash[:success] = "Workorder updated!"
            @workorder.state = @worklog.state #updates work order whenever worklog is created 
            @workorder.save
            redirect_back_or current_user
        end
        #render 'worker/show_assigned'
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
