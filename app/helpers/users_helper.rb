module UsersHelper
  def button_text_and_path_for_user(user)
    friend_request = current_user.friends.pending.find_by(receiver_id: user.id)
    if friend_request.present? || (params[:add_button_state] == 'sent' && params[:user_id] == user.id.to_s)
      button_text = 'Cancel Request'
      button_path = cancel_friend_request_homes_path(receiver_id: user.id)
    else
      button_text = 'Add Friend'
      button_path = add_friend_homes_path(receiver_id: user.id)
    end

    # Check if the friend request has been cancelled and update the button text accordingly
    if params[:cancelled_request] == 'true' && button_text == 'Cancel Request'
      button_text = 'Add Friend'
    end

    [button_text, button_path]
  end
end
