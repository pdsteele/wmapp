ActiveAdmin.register Workorder do
    controller { with_role :admin }  

    form do |f|
      f.inputs "Workorder Details" do
        f.input :user, :collection => User.order("name ASC").all.map{ |user| [user.name] }
        f.input :building, :collection => Buildings.order("name ASC").all.map{ |building| [building.name] } 
        f.input :room
        f.input :description
      end
      f.buttons
    end

end
