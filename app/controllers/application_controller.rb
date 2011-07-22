class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to(root_path, :notice => 'Sorry, but you cannot do that. If you would like to, or think you should, please contact an admin on <a href="http://forum.xda-developers.com/showthread.php?t=834868" target="_blank">XDA</a>.')
  end
end

