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
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Request sent" }
    end
  end

  def remove_friend
    friend = Friend.find(params[:friend]).update(status: 2) if params[:friend]
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Remove successfull" }
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
