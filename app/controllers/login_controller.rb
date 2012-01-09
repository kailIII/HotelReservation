#---
# Excerpted from "Agile Web Development with Rails, 2nd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails2 for more book information.
#---


class LoginController < ApplicationController



# . . 

  layout "application"

  def index
  end

  # just display the form and wait for user to
  # enter a name and password
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller => "rate", :action => "rate")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end
  
  def add_user
    logger.debug "Add user."
    @user = User.new(params[:user])
    if request.post? and @user.save
      @user = User.new
      redirect_to(:controller => "login", :action => "login")
      flash.now[:notice] = "User #{@user.name} created"
    end
  end

  def delete_user
    if request.post?
      user = User.find(params[:id])
      begin
        user.destroy
        flash[:notice] = "User #{user.name} deleted"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to(:action => :list_users)
  end
  

  
  def list_users
    @all_users = User.find(:all)
  end
  
  
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
  


end
