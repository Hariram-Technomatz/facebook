class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def profile
  end

  def send_request_to_user
    @users = current_user.check_user.where.not(id: current_user)
  end

  def add_friend
    friend = Friend.create(sender_id: current_user.id, receiver_id: params[:receiver_id], status: 0)
    redirect_to send_request_to_user_homes_path(add_button_state: 'sent', user_id: params[:receiver_id])
  end

  def cancel_friend_request
    friend = Friend.find_by(sender_id: current_user.id, receiver_id: params[:receiver_id], status: 'pending')
    if friend&.destroy
      redirect_back fallback_location: root_path, notice: "Friend request cancelled", cancelled_request: true
    else
      redirect_back fallback_location: root_path, alert: "Friend request not found"
    end
  end

  def remove_friend
    friend = Friend.find(params[:friend_id]).update(status: 2) if params[:friend_id]
    respond_to do |format|
      format.html { redirect_to my_request_homes_path, notice: "Remove successfull" }
    end
  end

  def my_request
    @requests = Friend.where receiver_id: current_user.id, status: 0
  end

  def accepted
    @requests = Friend.find(params[:id]).update(status: 1)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Request Accepted" }
    end
  end

  def my_friend
    @friends = Friend.accepted.where(receiver_id: current_user.id)
    @current_user_friends = current_user.friends.accepted
  end

end
