class SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    videos_path
  end

  def after_sign_up_path_for(resource)
    videos_path
  end

end