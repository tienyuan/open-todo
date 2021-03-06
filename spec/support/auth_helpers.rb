module AuthHelpers
  def auth_with_token(access_token)
    request.headers['X-ACCESS-TOKEN'] = "#{access_token}"
  end

  def clear_token
    request.headers['X-ACCESS-TOKEN'] = nil
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :controller
end
