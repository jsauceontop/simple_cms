class AccessController < ApplicationController
  layout 'admin'

  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
  	menu
  	render('menu')
  end
  def menu
  	#display text & links
  end

  def login
  	#login form
  end

  def attempt_login
  	#process the login
  	authorized_user = Subject.authenticate(params[:name], params[:password])
  	if authorized_user
  		#mark user as logged in
  		session[:user_id] = authorized_user.id
  		session[:name] = authorized_user.name
  		flash[:notice] = "you are logged in"
  		redirect_to(:action => 'menu')
  	else
  		flash[:notice] = "invalid username/password"
  		redirect_to(:action => 'login')
  	end
  end

  def logout
  		#mark user as logged out
  		session[:user_id] = nil
  		session[:name] = nil
  		flash[:notice] = "you have been logged out"
  		redirect_to(:action => 'login')
  end
end
