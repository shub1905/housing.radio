module ApplicationHelper

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
    return nil
  
  end
end
