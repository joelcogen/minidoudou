class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def authenticate_admin!
    unless authenticate_user! && current_user.admin
      redirect_to(request.referer, :notice => "Sorry, but you must be an admin to do that. Please ask an admin to make the change you need, or to promote you to admin.")
    end
  end
end

