require 'spec_helper'

describe Worker do
  
  #pending "add some examples to (or delete) #{__FILE__}"
  
  
 # :building, :description, :room, :state,  :user_id
  
  before do
  	@worker = Worker.new( name: "Example Worker", email: "example@wm.edu", phone: "18045678901", password: "ex", password_confirmation: "ex" ) 
 	@worker.save
  	
    @worker = Worker.first()
  	
  	@user = User.first()
  	
  	# puts "Errors: "
#   	puts "#{@worker.errors}"
  end


	subject{ @worker }

	# describe "Basic" do
# 		before { @user.save }
# 		 let(:found_worker) { Worker.find_by_email(@worker.email) }
# 		 puts found_worker.name
# 	 	it { should respond_to( :nothing ) }
# 	end

 
 
  subject{@worker}
	  
  it{ should respond_to(:name ) }
  it{ should respond_to(:email) }
  it{ should respond_to(:phone) }
  it{ should be_valid  }
  
  
  describe "Accept workorder " do
  
  		before { visit assigned_workorders_path }
  		before { @user.save } 
  	
  		let!(:submit) { "Create my account" }
  	
  		let(:found_worker) { Worker.find_by_email(@worker.email) }
  		describe "With empty text field" do
  		
  			# create a new workorder and assign it to the worker
  			@workorder = Workorder.new( description: "Test", building: "Adair", room: "34", state: "Assigned", user_id: @user.id )
  			
			
			
		end
  end
  
  
  describe "After workorder is accepted, state should change to 'In Progress'" do
  
  	before { @worker.save }	
  
	let(:found_worker) { Worker.find_by_email(@worker.email) }

	#puts found_worker.id 
	  
    # puts @workorder.valid?
#  	@workorder.should be_valid
  
  	# @workorder = Workorder.new( description: "Test", building: "Adair", room: "34", state: "Assigned", user_id: found_worker.id )

  
  end
  
  
  
  
  
  
end
