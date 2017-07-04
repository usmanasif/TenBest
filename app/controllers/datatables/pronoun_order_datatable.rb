class Datatables::PronounOrderDatatable
	delegate :params, :h, :link_to, :button_to, :hidden_field_tag, :select_tag, :current_user, :options_for_select, to: :@view
	include Rails.application.routes.url_helpers
	include PronounOrdersHelper
	include ActionView::Helpers::DateHelper

	def initialize(view, user, view_point)
	  @view = view
	  @user = user
		@view_point = view_point
	end

	def as_json(options = {})
			puts
		  {
		    sEcho: params[:sEcho].to_i,
		    iTotalRecords: orders.count,
		    iTotalDisplayRecords: orders.count,
		    aaData: data,
		  }
	end

	private
	def data
			orders.map do |order|
		    [
						link_to(order.id, order),
						ERB::Util.h("<p class='entry-title'>#{order.title}</p>".html_safe),
						ERB::Util.h(order.try(:category).try(:name)),
						ERB::Util.h(order.description),
						ERB::Util.h(order.keywords),
						ERB::Util.h("#{order.min_words}-#{order.max_words}"),
						link_to(create_tag(order.state).html_safe, order)
				]
		end
	end

	def orders
  	@orders ||= fetch_orders
	end

  def fetch_orders
    orders = PronounOrder.all
    orders = orders.paginate(:page => page, :per_page => per_page)
    if params[:sSearch].present?
    	result = fetch_search_result_orders(orders, params[:sSearch])
    	orders = result.uniq
    end
    orders.order('updated_at DESC')
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

end
