# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '02d25e5c93a0b4b61a6b56d1ef834c08'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  #before_filter :check_auth
  #def check_auth
  #  true
  #end
  
  before_filter :set_app_title
  def set_app_title
    @app_title  = "My Scaffolded Application"
    @app_footer = "Created with shiny Minni's Application Scaffolder"
  end
end