class WebService
  require 'uri'
  require 'net/http'

  def self.get(url, params = {})
    uri = URI(url)
    uri.query = URI.encode_www_form(params)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request["content-type"] = 'application/x-www-form-urlencoded'

    response = http.request(request)
    yield response
  end

  def self.post(url, body, params = {})
    uri = URI(url)
    uri.query = URI.encode_www_form(params)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request.body = body

    response = http.request(request)
    yield response
  end
end
