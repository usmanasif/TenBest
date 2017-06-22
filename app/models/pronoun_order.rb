class PronounOrder < ApplicationRecord
  require 'json'
  require 'web_service'

  belongs_to :company
  after_create :place_order_with_pronoun

  def place_order_with_pronoun
    url = "https://pronoun-io.herokuapp.com/api/v1/orders"
    body = "category=industry&description=Please write a brief description of #{self.company.name} as one of the best #{self.company.category.name} in #{self.company.city}. They are located at #{self.company.address}. You can learn more about them by visiting their website.&title=#{self.company.name}&quality_level=4&processing_time=2&word_count_start=#{self.min_words}&word_count_end=#{self.max_words}&seo_words=#{self.company.category.name} in #{self.company.city}&callback_url=https://tenbestcity.herokuapp.com/admin/pronoun_orders/#{self.id}/text_submission_callback"

    WebService.post(url, body) do |response|
      body = JSON.parse response.read_body
      self.update_attributes!(pronun_id: body["order_id"]) unless body["order_id"].nil?
    end
  end

  # Encapsulates 3(Accept, Reject and Revise API Calls) through 1 function
  def order_review_webhook(button, comment)
    url = "https://pronoun-io.herokuapp.com/api/v1/orders/#{self.pronun_id}/#{button}"
    WebService.get(url, {comment: comment}) do |response|
      return response
    end
  end

  def get_status_string
    puts "State of order : " + self.state
    if self.state == "Accept"
      "Order has been Accepted"
    elsif self.state == "Revise"
      "Revision requested for this order"
    elsif self.state == "Reject"
      "Order has been Rejected"
    end
  end

  private
end
