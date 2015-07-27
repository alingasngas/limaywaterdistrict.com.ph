class Admin::MainController < ApplicationController
	
	include Admin::MainModule
	before_filter :set_title
	
	def set_title
	  @title = 'Dashboard'
	end
	
	def index
    
	end
	
	def common_update
	  this = params[:target].classify.constantize
	  obj = this.find(params[:id])
	  obj.toggle(params[:scope].to_sym)
	  obj.save
	  redirect_to :controller => params[:target], :action => "index"
	   
	end
	
end
