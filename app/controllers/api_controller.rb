class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :restrict_access

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  private

  def restrict_access
    access_token = request.headers['X-ACCESS-TOKEN']
    @authenticated_user = ApiKey.where(access_token: access_token).first.user if access_token

    unless @authenticated_user
        head status: :unauthorized
      return false
    end
  end
end