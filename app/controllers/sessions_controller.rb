class SessionsController < ApplicationController
  def new
    @title ="Sign in"
  end
  
  # create handles form submission and makes new session
  def create
    render 'new'  # show blank forms
  end
  
  # accessed via HTTP DELETE, deletes a session
  def destroy
    
  end
end
