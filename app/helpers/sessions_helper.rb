module SessionsHelper

  def sign_in_(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in_user?
    !current_user.nil? && current_user.class == User
  end

  def signed_in_worker?
    !current_user.nil? && current_user.class == Worker
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Worker.find_by_remember_token(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) 
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in_user?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def signed_in_worker
    unless signed_in_worker?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def sign_out_
    cookies.delete(:remember_token)
    @current_user = nil #was self.current_user
    self.current_user = nil
  end

end
