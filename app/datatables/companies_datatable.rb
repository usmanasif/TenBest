class CompaniesDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: companies.count,
      iTotalDisplayRecords: companies.count,
      aaData: data
    }
  end

  private

  def data
    companies.map do |company|
      [
        ERB::Util.h(company.id),
        link_to(company.name, company),
        ERB::Util.h(company.city),
        ERB::Util.h(company.category.name),
        ERB::Util.h(company.rating),
        link_to("<span class='glyphicon glyphicon-edit'></span>".html_safe, edit_company_path(id: company.id)),
        link_to("<span class='glyphicon glyphicon-remove'></span>".html_safe, company, method: :delete, data: { confirm: 'Are you sure?' })
      ]
    end
  end

  def companies
    @companies ||= fetch_companies
  end

  def fetch_companies
    companies = Company.order("#{sort_column} #{sort_direction}")
    companies = companies.page(page).per_page(per_page)
    if params[:sSearch].present?
      companies = companies.where('name ILIKE :search or city ILIKE :search or CAST(category_id AS TEXT) ILIKE :search', search: "%#{params[:sSearch]}%")
    end
    companies
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ["id", "name", "city", "category_id","rating"]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
