ActiveAdmin.register Worker do

    controller { with_role :admin }

    form do |f|
      f.inputs "Worker Details" do
        f.input :name
        f.input :email
        f.input :phone
        f.input :password
        f.input :password_confirmation
      end
      f.buttons
    end
  #form :partial => "form"

end
