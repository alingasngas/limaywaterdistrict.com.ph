module Admin::MainModule


  def self.included(base)
    base.before_filter :login_required
    base.helper_method :current_user, :logged_in?, :redirect_to_target_or_default, :is_admin?, :is_editor?
    base.layout "administration"
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user
  end
  
  def login_required
    if session[:user_id]
      return true
    elsif cookies[:remember_me_id] and cookies[:remember_me_code] and User.exists?(cookies[:remember_me_id]) and Digest::SHA1.hexdigest(User.where(:id => cookies[:remember_me_id]).first.email)[4,18] == cookies[:remember_me_code]
      user = User.find(cookies[:remember_me_id])  
      session[:user_id] = user.id
      return true
    else
	    redirect_to :controller => 'admin/session', :action => "new"
     	return false
    end

  end
  

  def redirect_to_stored
    if return_to = session[:return_to_url]
      session[:return_to_url] = nil
      redirect_to(return_to)
    else
      redirect_to :controller => 'admin/main', :action => "index"
    end
  end

  def return_to
    # code here
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end
  
  def is_admin?
    current_user.is_admin?
  end
  
  def is_editor?
    current_user.is_editor?
  end
  
  
    
  def parse_date(date)
    date1_regex = /\d{1,2}\/\d{1,2}\/\d{4}/  # "mm/dd/yyyy"
    date2_regex = /\d{4}-\d{1,2}-\d{1,2}/    # "yyyy-mm-dd" 
    if date.is_a? String
      if date1_regex =~ date   
        return Date.strptime(date, '%m/%d/%Y')
      elsif date2_regex =~ date 
        return Date.parse(date)
      else
        raise ArgumentError, "Invalid date format for '#{date}'"
      end
    elsif date.is_a? Date
      return date
    else
      raise ArgumentError, "Invalid date format for '#{date}'"
    end
    
  end

  def transliterate_link(str)
    s = Iconv.iconv('ascii//ignore//translit', 'utf-8', str).to_s
    s.downcase!
    s.gsub!(/'/, '')
    s.gsub!(/[^A-Za-z0-9]+/, ' ')
    s.strip!
    s.gsub!(/\ +/, '-')
    return s
  end
  
  private

  def store_target_location
    session[:return_to] = request.url
  end  
end