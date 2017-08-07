module PronounOrdersHelper
  def fetch_search_result_orders(orders, params_search)
    orders = orders.where('title ILIKE :search or description ILIKE :search', search: "%#{params_search}%")
  end

  def create_tag(state)
    if state == 'order placed'
      "<span class='tag label label-primary'>" + state + '</span>'.html_safe
    elsif state == 'Ready For Pickup'
      "<span class='tag label label-info'>" + state + '</span>'.html_safe
    elsif state == 'Accept'
      "<span class='tag label label-success'>" + state + '</span>'.html_safe
    elsif state == 'Reject'
      "<span class='tag label label-danger'>" + state + '</span>'.html_safe
    elsif state == 'Revise'
      "<span class='tag label label-warning'>" + state + '</span>'.html_safe
    else
      "<span class='tag label label-default'>" + state + '</span>'.html_safe
    end
  end
end
