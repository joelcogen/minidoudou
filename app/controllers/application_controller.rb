class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def authenticate_admin!
    authenticate_user! if current_user.nil?
    unless current_user.admin
      redirect_url = request.referer
      redirect_url = root_path if request.url == redirect_url
      redirect_to(redirect_url, :notice => "Sorry, but you must be an admin to do that. Please ask an admin to make the change you need, or to promote you to admin.")
    end
  end
end

