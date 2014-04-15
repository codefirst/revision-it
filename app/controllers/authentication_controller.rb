class AuthenticationController < ApplicationController
  include ErrorHandle
  skip_before_action :authenticate_user!

  def login
    redirect_to root_path
  end

  def github
    name = get_name(request)
    return unless name

    user = current_user || User.where(name: name).first_or_create!
    user.name = name
    user.save!
    sign_in user, event: :authentication
    redirect_to dashboard_path
  end

  def logout
    reset_session
    sign_out current_user
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: t(:error_authentication_failed)
  end

  private
  def get_name(request)
    request.env['omniauth.auth']['info']['nickname'] || error('bad payload of github',400)
  rescue => e
    Rails.logger.error e.backtrace.join("\t")
    error('bad payload of github', 400)
  end
end
