class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  helper_method :current_user_session, :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  
  protected
  def logged_in?
    !current_user_session.nil?
  end
  
  def require_user
    unless current_user
      respond_to do |wants|
        wants.any(:json, :js, :xml) {
          render :text => "Access Denied", :status => :unauthorized
        }
        wants.html {
          store_location
          flash[:notice] = "You must be logged in to access this page"
          redirect_to login_url
        }
      end
      return false
    end
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user  = current_user_session && current_user_session.user
  end

  # Store the URI of the current request in the session.
  #
  # We can return to this location by calling #redirect_back_or_default.
  def store_location
    logger.info(request.fullpath)
    session[:return_to] = request.fullpath
  end

  # Redirect to the URI stored by the most recent store_location call or
  # to the passed default.  Set an appropriately modified
  #   after_filter :store_location, :only => [:index, :new, :show, :edit]
  # for any controller you want to be bounce-backable.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def access_denied
    render :text=>"Access Denied", :status => :forbidden
  end

  def not_found
    # IMPORTANT: If you modify this method, you have to restart the server.
    respond_to do |format|
      format.html { render :file=>"public/404.html", :status=>:not_found}
      format.js   { render :text=>"Not Found", :status=>:not_found}
      format.xml  { render :text=>"Not Found", :status=>:not_found}
    end
  end

end