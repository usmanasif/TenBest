class PronounOrdersController < ApplicationController
  # before_action :authenticate_admin!

  def index
    @orders = PronounOrder.all
  end

  def show
    @order = PronounOrder.find(params[:id])
  end

  def text_submission_callback
    puts "==============================="
    puts "==============================="
    puts params.inspect
    puts "==============================="
    puts "==============================="
    puts "==============================="
    order = PronounOrder.find(params[:pronoun_order_id])
    order.update_attributes(submitted_text: params[:valued_text],state: "Ready For Pickup",pronoun_id: params[:order_id])
  end

  def order_review
    return render json: params
    order = PronounOrder.find(params[:pronoun_order_id])
    button = params[:button]
    order.order_review_callback(button)
    if button == "accept_order"
      if order.max_words == 125
        order.company.intro
      end
      order.company.update_attribute(:)
  end

end
