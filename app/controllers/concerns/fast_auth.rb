module FastAuth
  def fast_authenticate_user!
    return if user_signed_in?
    session['user_return_to'] = request.fullpath
    redirect_to main_app.user_fast_path
  end
end
