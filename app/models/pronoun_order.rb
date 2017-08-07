class PronounOrder < ApplicationRecord
  require 'json'
  require 'web_service'

  belongs_to :company
  after_create :place_order_with_pronoun

  def place_order_with_pronoun
    url = 'https://pronoun-io.herokuapp.com/api/v1/orders'
    body = "category=industry&description=Please write a brief description of #{company.name} as one of the best #{company.category.name} in #{company.city}. They are located at #{company.address}. You can learn more about them by visiting their website.&title=#{company.name}&quality_level=4&processing_time=2&word_count_start=#{min_words}&word_count_end=#{max_words}&seo_words=#{company.category.name} in #{company.city}&callback_url=https://tenbestcity.herokuapp.com/admin/pronoun_orders/#{id}/text_submission_callback"

    WebService.post(url, body) do |response|
      body = JSON.parse response.read_body
      update_attributes!(pronun_id: body['order_id']) unless body['order_id'].nil?
    end
  end

  # Encapsulates 3(Accept, Reject and Revise API Calls) through 1 function
  def order_review_webhook(button, comment)
    url = "https://pronoun-io.herokuapp.com/api/v1/orders/#{pronun_id}/#{button}"
    WebService.get(url, comment: comment) do |response|
      return response
    end
  end

  def get_status_string
    puts 'State of order : ' + state
    if state == 'Accept'
      'Order has been Accepted'
    elsif state == 'Revise'
      'Revision requested for this order'
    elsif state == 'Reject'
      'Order has been Rejected'
    end
  end
end
