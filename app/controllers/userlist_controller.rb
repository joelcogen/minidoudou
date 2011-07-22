class UserlistController < ApplicationController
  def index
    authorize! :manage, :user
    @users = User.all.sort_by {|u| u.admin ? 0 : 1 }
  end

  def delete
    authorize! :manage, :user
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to userlist_path, :notice => "Suicidal much?"
    else
      @user.destroy
      redirect_to userlist_path, :notice => "User '#{@user.name}' deleted"
    end
  end

  def toggleadmin
    authorize! :manage, :user
    @user = User.find(params[:id])
    if @user == current_user
      redirect_to userlist_path, :notice => "Nope, bad idea"
    else
      @user.update_attribute :admin, !@user.admin
      redirect_to userlist_path, :notice => "User '#{@user.name}' updated"
    end
  end
end
