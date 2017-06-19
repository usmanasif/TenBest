require 'uri'
require 'net/http'

class WebService

  def self.get(url)
    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)
    if uri.instance_of?  URI::HTTPS
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    end

    request = Net::HTTP::Post.new(url)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request["content-type"] = 'application/x-www-form-urlencoded'

    response = http.request(request)
    yield response
  end

  def self.post(url, body)
    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)
    if uri.instance_of?  URI::HTTPS
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE  
    end

    request = Net::HTTP::Post.new(url)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request["content-type"] = 'application/x-www-form-urlencoded'
    request.body = body

    response = http.request(request)
    yield response
  end
end
