class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :restrict_access

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  private

  def restrict_access
    access_token = request.headers['X-ACCESS-TOKEN']
    api_key = ApiKey.where(access_token: access_token).first if access_token
    @authenticated_user = api_key.user if api_key

    unless @authenticated_user
        head status: :unauthorized
      return false
    end
  end
end