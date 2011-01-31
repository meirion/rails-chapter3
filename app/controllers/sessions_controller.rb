class SessionsController < ApplicationController
  def new
    @title ="Sign in"
  end
  
  # create handles form submission and makes new session
  def create
    #render 'new'  # show blank forms
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      #create error message and re-render signin form
      flash.now[:error] = "Sorry your username and/or password were not correct."
      @title = "Sign in"
      render = 'new'
    else
      #sign the user in and redirect to the user's show page
    end
              
  end
  
  # accessed via HTTP DELETE, deletes a session
  def destroy
    
  end
end
