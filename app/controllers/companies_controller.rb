class CompaniesController < ApplicationController
  require 'net/http'
  before_action :authenticate_admin!
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]
  before_action :set_layout

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    @category = Category.new
    respond_to do |format|
      format.html
      format.json { render json: CompaniesDatatable.new(view_context) }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show; end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save!
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, alert: 'company could not be created' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
    # get_info @company
    # @company.place_order_with_pronoun
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      company_params[:setting] ||= {}
      if @company.update(company_params)
        if @company.save!
          format.html { redirect_to @company, notice: 'Company was successfully updated.' }
          format.json { render :show, status: :ok, location: @company }
        else
          format.html { render :new, alert: 'company could not be updated' }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, alert: 'category could not be updated' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
    @company.get_info
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_csv
    file = params[:file]
    @category = params[:category]
    @csv_companies = import_from_csv(file, Company)
    if @csv_companies.present?
      @correct_companies = []
      @csv_companies.each do |company|
        company['settings'] = YAML.load(company['settings'].tr('’', '\'').tr('‘','\''))
        if Company.invalid company
          company['error'] = true
        else
          @correct_companies.push company
        end
      end
      render 'import_from_csv.html.erb'
    else
      redirect_to :back, alert: 'CSV is in invalid format'
    end
  end

  def create_from_list
    companies = params[:companies]
    category = params[:category_select]
    companies.each do |company|
      company = company.slice(:name, :city, :address,:url,:rating,:contact,:settings)
      company[:category_id] = category
      Company.create company.to_hash unless Company.invalid company
    end
    redirect_to companies_url, notice: 'Companies were successfully imported.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :city, :category_id, :lat, :lng, :address, :url, :contact, images: [], settings: [:key, :value])
    params.require(:company).permit!
  end

  def set_layout
    self.class.layout 'admin'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.friendly.includes(:pictures).find(params[:id])
  end

  def set_categories
    @categories = Category.all
    @cities = ['San Francisco', 'New York', 'Honolulu']
  end
end
