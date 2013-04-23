class WorklogsController < ApplicationController

    def new
        @worklog = Worklog.new
        @worklog.state = @worklog.workorder.state
    end #end function 

    def create
        @workorder = Workorder.find(params[:workorder_id])
        @worklog = @workorder.worklogs.new(params[:worklog])
        
        if (@worklog.name.nil?)
            @worklog.name = current_user.name
        end

        if (@worklog.state == "Deferred")
            @worklog.fac_man_only = true
        end

        if (@worklog.state.nil?)
            @worklog.state = @workorder.state
        end

        if (@worklog.unsolicited.nil?)
            @worklog.unsolicited = false
        end

        if (@worklog.worker.nil?)
                @worklog.worker_id = @workorder.worker_id
        end

        if (@worklog.save)
            @workorder.state = @worklog.state #updates work order whenever worklog is created 
            @workorder.updated_at = @worklog.updated_at #update 'updated' time for workorder 
            
            if (@workorder.save)
                flash[:success] = "Workorder updated!"
                redirect_back_or current_user
            end

        else
            flash[:error] = "Cannot submit blank update"
            redirect_back_or current_user
        end
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
