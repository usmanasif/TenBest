class PronounOrder < ApplicationRecord

  belongs_to :company
  after_create :place_order_with_pronoun

  private

  def place_order_with_pronoun
    puts "============================="
    puts "placing order"
    require 'uri'
    require 'net/http'

    url = URI("https://pronoun-io.herokuapp.com/api/v1/orders")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request["content-type"] = 'application/x-www-form-urlencoded'
    request.body = "category=industry&description=Please write a brief description of #{self.company.name} as one of the best #{self.company.category.name} in #{self.company.city}. They are located at #{self.company.address}. You can learn more about them by visiting their website.&title=#{self.company.name}&quality_level=4&processing_time=2&word_count_start=#{self.min_words}&word_count_end=#{self.max_words}&seo_words=#{self.company.category.name} in #{self.company.city}&callback_url=https://4d4f9a12.ngrok.io/admin/pronoun_orders/#{self.id}/text_submission_callback"

    response = http.request(request)

    puts "--------------------------------------"
    puts "--------------------------------------"
    puts response.read_body
    puts "--------------------------------------"
    puts "--------------------------------------"


    # request.body = "category=industry&description=Please write a brief description of #{self.name} as one of the best #{self.category.name} in #{self.city}. They are located at #{self.address}. You can learn more about them by visiting their website.
    # &title=#{self.name}&quality_level=4&processing_time=2&word_count_start=150&word_count_end=250&seo_words=#{self.category.name} in #{self.city}"

    # response = http.request(request)

    # puts "--------------------------------------"
    # puts "--------------------------------------"
    # puts response.read_body
    # puts "--------------------------------------"
    # puts "--------------------------------------"

  end

  def order_review_webhook(button)
    require 'uri'
    require 'net/http'

    url = URI("https://pronoun-io.herokuapp.com/api/v1/orders/#{order.pronoun_id}/#{button}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["access_id"] = Rails.application.secrets.pronoun_access_id
    request["time"] = Time.now
    digest = Digest::MD5.hexdigest("#{request['time']}:#{Rails.application.secrets.pronoun_auth_token}")
    request["content-md5"] = digest
    request["content-type"] = 'application/x-www-form-urlencoded'

    response = http.request(request)

    puts "--------------------------------------"
    puts "--------------------------------------"
    puts response.read_body
    puts "--------------------------------------"
    puts "--------------------------------------"
  end
end
