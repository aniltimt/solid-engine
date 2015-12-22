class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def listing
    @users = User.all.order('created_at DESC')
  end

  def approve
    @user = User.find(params[:id])
    if @user
      @user.update_attributes(status: true)
      NotifyMailer.approve_email(@user).deliver_now
      redirect_to users_listing_path, :notice => "User successfully approved."
    else
      redirect_to :back, :alert => "Unable to approve user."
    end    
  end

  def disapprove
    @user = User.find(params[:id])
    if @user
      @user.update_attributes(status: false)
      NotifyMailer.disapprove_email(@user).deliver_now
      redirect_to users_listing_path, :alert => "User successfully disapproved."
    else
      redirect_to :back, :alert => "Unable to disapprove user."
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
