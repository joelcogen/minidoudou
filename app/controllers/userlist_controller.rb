class UserlistController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
    @users = User.all.sort_by {|u| u.admin ? 0 : 1 }
  end

  def delete
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to userlist_path, :notice => "Suicidal much?"
    else
      @user.destroy
      redirect_to userlist_path, :notice => "User '#{@user.name}' deleted"
    end
  end

  def toggleadmin
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to userlist_path, :notice => "Nope, bad idea"
    else
      @user.update_attribute :admin, !@user.admin
      redirect_to userlist_path, :notice => "User '#{@user.name}' updated"
    end
  end
end
