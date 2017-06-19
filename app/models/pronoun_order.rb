class PronounOrder < ApplicationRecord
  require 'web-service'

  belongs_to :company
  after_create :place_order_with_pronoun

  private

  def place_order_with_pronoun
    url = "https://pronoun-io.herokuapp.com/api/v1/orders"
    body = "category=industry&description=Please write a brief description of #{self.company.name} as one of the best #{self.company.category.name} in #{self.company.city}. They are located at #{self.company.address}. You can learn more about them by visiting their website.&title=#{self.company.name}&quality_level=4&processing_time=2&word_count_start=#{self.min_words}&word_count_end=#{self.max_words}&seo_words=#{self.company.category.name} in #{self.company.city}&callback_url=http://4167b86c.ngrok.io/admin/pronoun_orders/#{self.id}/text_submission_callback"

    WebService.post(url, body) do |response|
      puts "--------------------------------------"
      puts "--------------------------------------"
      puts response.read_body
      puts "--------------------------------------"
      puts "--------------------------------------"
    end
  end

  def order_review_webhook(button)
    url = "https://pronoun-io.herokuapp.com/api/v1/orders/#{order.pronoun_id}/#{button}"
    WebService.get(url) do |response|
      puts "--------------------------------------"
      puts "--------------------------------------"
      puts response.read_body
      puts "--------------------------------------"
      puts "--------------------------------------"
    end
  end
end
