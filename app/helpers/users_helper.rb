# frozen_string_literal: true

module UsersHelper
  def edit_your_profile(user)
    user_signed_in? && current_user.id == user.id
  end

  def pending_request?(user)
    current_user.pending_friend?(user)
  end

  def existing_relation(user)
    current_user.related?(user) || current_user.id == user.id
  end
end
