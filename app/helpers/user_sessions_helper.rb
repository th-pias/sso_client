module UserSessionsHelper
  def generate_url(url)
    uri = URI(url)
    uri.query = {app_id: ENV['app_id'], secret_key: ENV['secret_key']}.to_query
    uri.to_s
  end
end
