
require 'spec_helper'
require 'database_cleaner'


describe Worker do
  
  
  

  
	 #  before do
# 		@worker = Worker.new( name: "Example Worker", email: "example@wm.edu", phone: "18045678901", password: "ex", password_confirmation: "ex" ) 
# 		@worker.save
# 		
# 		#puts @worker.nil?#-- returns false
# 		
# 	  end

	# it{ should respond_to(:name ) }
# 	it{ should respond_to(:email) }
# 	it{ should respond_to(:phone) }
# 	it{ should be_valid  }

	subject{ page }
	

	
	
	describe "Accept workorder" do
	
		let!(:worker1)   { FactoryGirl.create(:worker)  }
		let!(:user1)     { FactoryGirl.create(:user)    }   
		let!(:workorder1){ FactoryGirl.create(:workorder, worker: worker1, state: "Assigned", user: user1) } #
# 		
# 		
# 		# can't get the worklog factory working for some reason
# 		 let!(:worklog ) do 
# # 			#@workorder =Workorder.new()
# # 			#declare worklogs
# # 			@workorder =Workorder.all[0]
#  			@worklog = Worklog.new(description: "test", fac_man_only: false, name: "This", state: "Assigned", workorder_id: workorder.id, workorder: workorder, unsolicited: false) 
#  			@worklog.save
#  			
#  			puts "Is the worklog valid?"
#  			puts @worklog.valid?
# 		end

		
		

		before do
			@worklog = workorder1.worklogs.build( description: "test", fac_man_only: false, name: "This", state: "Assigned", workorder_id: workorder1.id, workorder: workorder1, unsolicited: false )
		end


		before do
			puts "Here is the description"
			#puts workorder.worklogs.first #<== This doesnt give any error and does the right thing
			#puts @worklog.valid?
			puts workorder1.worklogs   #<== This line gives error:  ActionView::Template::Error:wrong number of arguments (0 for 1)
		end
		
		

		#let!(:worklog ) { FactoryGirl.create(:worklog, workorder_id: workorder.id, workorder: workorder) }
		#attr_accessible :description, :fac_man_only, :name, :state, :workorder_id, :workorder,  :unsolicited, :worker_id
		
		
		before{ sign_in( worker1 ) }

		before{ visit '/assigned_workorders' }
		
		
		
		describe "With empty text field" do
		
			it { should have_selector('h1', text: "Assigned/Deferred/Reopened Workorders") }

			
		end
	
	
		# describe "After workorder is accepted, state should change to 'In Progress'" do
# 		
# 			#before { @worker.save }
# 			
# 			# let(:found_worker) { Worker.find_by_email(@worker.email) }
# # 			before { visit assigned_workorders_path }
# 	
# 			it { should have_selector('h1', text: "Assigned Workorders") }
# 			
# 			
# 			#puts found_worker.id 
# 			  
# 			# puts @workorder.valid?
# 			#  	@workorder.should be_valid
# 			
# 			# @workorder = Workorder.new( description: "Test", building: "Adair", room: "34", state: "Assigned", user_id: found_worker.id )
# 			
# 		
# 			end
	end  
		
end
  
  
  
  
  

