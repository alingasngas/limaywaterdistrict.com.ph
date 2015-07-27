class Admin::SessionController < ApplicationController
	include Admin::MainModule
	layout 'session'
	before_filter	:login_required, :except => [:new, :create]
	def new
		
	end
	
	def create
    if request.post?
      @user = User.authenticate(params[:login],params[:password])
      if @user
        if @user.status?
          @user.update_attributes(:last_login_at => Time.current, :last_ip => request.env['REMOTE_ADDR'])
          session[:user_id] = @user.id
          if params[:remember_me]
            userId = @user.id.to_s
            cookies[:remember_me_id] = {:value => userId, :expires => 30.days.from_now}
            userCode = Digest::SHA1.hexdigest(@user.email)[4,18]
            cookies[:remember_me_code] = {:value => userCode, :expires => 30.days.from_now}
          end
          flash[:success]= 'Logged in successfully.'
          redirect_to_target_or_default admin_url
          return
        else
          flash[:warning] = 'User has been disabled!'
          render :action => 'new'
        end
      else
        flash[:error] = 'Invalid username or password!'
        render :action => 'new'
      end
    else
      if cookies[:remember_me_id] and cookies[:remember_me_code] and User.exists?(cookies[:remember_me_id]) and Digest::SHA1.hexdigest(User.where(:id => cookies[:remember_me_id]).first.email)[4,18] == cookies[:remember_me_code]
        user = User.find(cookies[:remember_me_id])
        session[:user_id] = user.id

        redirect_to_target_or_default admin_root_url
        return
      end
    end
    
	end
	
	def destroy
    session[:user_id] = nil
    redirect_to admin_login_page_url, :success => "You have been logged out."
	end
	
end
