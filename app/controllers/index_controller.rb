class IndexController < ApplicationController
  add_breadcrumb 'home', :root_path
  def home
    @categories = Category.first(5)
  end

  def about; end

  def contact
    unless params[:contact].nil?
      @user = params[:contact]
      @result = if ContactMailer.welcome_email(@user).deliver_now
                  'Success!'
                else
                  'Failure!'
                end
    end
  end

  def place
    @no = params[:company].nil? ? 1 : Company.find_by_name(url_decode(params[:company])).id
    @company = Company.find(@no)
    @rank = params[:rank]
    @keywords = @company.category.keywords.split(',')
    @position = get_info @company

    # Track an Event (all values optional)
    staccato.event(category: 'All-Links', action: @company.name, label: 'Company', value: @company.id)
    staccato.event(category: @company.category.name, action: @company.name, label: 'Company', value: @company.id)
    staccato.event(category: 'All-Links', action: 'Ranking Position # ' + @rank.to_s, label: @company.name, value: @rank)
    staccato.event(category: @company.category.name, action: 'Ranking Position # ' + @rank.to_s, label: @company.name, value: @rank)

    # analytics.track_company_all @company.name
    # analytics.track_company_category @company.name, @company.category.name
    # analytics.track_company_rank_all @company.name, @no.to_s
    # analytics.track_company_rank_category @company.name, @no.to_s, @company.category.name

    add_breadcrumb @company.category.name, ranking_path(@company.category)
    add_breadcrumb @company.name, place_path(@company)
  end

  def ranking
    @category = params[:category].nil? ? Category.first : Category.find_by_name(url_decode(params[:category]))
    @keywords = @category.keywords.split(',')
    @companies = Company.where('category_id = ?', @category.id).order('rating DESC').first(10)
    @positions = []
    @companies.each_with_index do |company, index|
      position = get_info(company)
      position['rank'] = index
      @positions.push position
    end

    add_breadcrumb @category.name, ranking_path(@category)
  end

  def search
    @category = if params[:search_select].nil? || params[:search_select] == ''
                  nil
                else
                  params[:search_select]
                end

    if @category.nil?
      if params[:search] == '' || params[:search].nil?
        @companies = nil
      else
        @search_str = params[:search]
        # @companies = Company.where("name LIKE ?", "%#{params[:search]}%") if Rails.env.development?
        @companies = Company.where('name ILIKE ?', "%#{params[:search]}%")
      end
    else
      @search_str = params[:search]
      # @companies = Company.where( "name LIKE ? AND category = ?", "%#{params[:search]}%", @category)if Rails.env.development?
      @companies = Company.where('name ILIKE ? AND category_id = ?', "%#{params[:search]}%", @category)
    end
    if params[:limit].nil?
      @companies = @companies.to_a.slice(0, 8) if @companies.to_a.length > 8
    end
    @limit = params[:limit]
  end

  def share_up
    @company = Company.find(params[:id]) unless params[:id].nil?
    ip = Ip.where('address = ? AND company_id = ?', get_ip, params[:id]).first
    if ip.nil?
      @share = if @company.share.nil?
                 1
               else
                 @company.share + 1
               end
      @company.update(share: @share)
      ip = Ip.new(address: get_ip, company_id: params[:id], share: 1)
      ip.save
    elsif ip.share.nil?
      @share = @company.share + 1
      @company.update(share: @share)
      ip.update(share: 1)
    else
      @share = @company.share
    end
  end

  def like_up
    @company = Company.find(params[:id]) unless params[:id].nil?
    ip = Ip.where('address = ? AND company_id = ?', get_ip, params[:id]).first
    if ip.nil?
      @like = if @company.like.nil?
                1
              else
                @company.like + 1
              end
      @company.update(like: @like)
      ip = Ip.new(address: get_ip, company_id: params[:id], like: 1)
      ip.save
    elsif ip.like.nil?
      @like = @company.like + 1
      @company.update(like: @like)
      ip.update(like: 1)
    else
      @like = @company.like
    end
  end
end
