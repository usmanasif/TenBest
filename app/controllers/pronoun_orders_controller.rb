class PronounOrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:text_submission_callback]
  before_action :set_layout

  def index
    @orders = PronounOrder.all
    @empty_orders = @orders.select{ |item| item[:pronoun_id] == nil }
    @view_point = params[:view_point] || ''
    respond_to do |format|
      format.html
      format.json { render json: ::Datatables::PronounOrderDatatable.new(view_context, current_admin, @view_point) }
    end
  end

  def show
    @order = PronounOrder.find(params[:id])
  end

  def text_submission_callback
    order = PronounOrder.find(params[:pronoun_order_id])
    order.update_attributes(submitted_text: params[:valued_text], state: "Ready For Pickup")
  end

  def order_review
    order = PronounOrder.find(params[:pronoun_order_id])
    button = params[:commit].downcase + "_order"
    comment = params[:comment_text]
    response = order.order_review_webhook(button, comment)
    if response.code == "200"
      if button == "accept_order"
        if order.max_words == 125
          order.company.update_attributes!(intro: order.submitted_text)
        else
          order.company.update_attributes!(description: order.submitted_text)
        end
        redirect_to company_path(order.company)
      elsif button == "revise_order"
        redirect_to pronoun_orders_path, notice: "Order Revised"
      elsif button == "reject_order"
        redirect_to pronoun_orders_path, notice: "Order Rejected"
      end
    end
    order.update_attributes!(state: params[:commit])
  end
  def place_order
    order = PronounOrder.find(params[:pronoun_order_id])
    order.place_order_with_pronoun

    redirect_to pronoun_orders_path, notice: "Order Placed Successfully"

    # render json: {msg: "Order Placed Successfully" }, status: 200
  end

  private
  def set_layout
    self.class.layout "admin"
  end
end
