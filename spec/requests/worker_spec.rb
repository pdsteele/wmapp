
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
	
		 let(:worker)   { FactoryGirl.create(:worker) }
		let!(:user)     { FactoryGirl.create(:user) }   
		let!(:workorder){ FactoryGirl.create(:workorder, worker: worker, state: "Assigned", user: user) } #
		
		before{ sign_in( worker ) }

		before{ visit '/assigned_workorders' }
		
		
		
		describe "With empty text field" do
		
			it { should have_selector('h1', text: "Assigned Workorders") }

			
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
  
  
  
  
  

