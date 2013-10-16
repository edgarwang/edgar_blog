class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    raise request.env['omniauth.auth'].to_yaml
  end
end
