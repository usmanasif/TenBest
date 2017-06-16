class CompaniesController < ApplicationController
  require 'net/http'
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    # @companies = Company.all
    @category = Category.new
    respond_to do |format|
      format.html
      format.json { render json: CompaniesDatatable.new(view_context) }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show

  end

  # GET /companies/new
  def new
    @company = Company.new
    @categories = Category.all
    @cities = ["San Francisco", "New York", "Honolulu"]
  end

  # GET /companies/1/edit
  def edit
    @categories = Category.all
    @cities = ["San Francisco", "New York", "Honolulu"]
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save!
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
    get_info @company
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
    get_info @company
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
    @csv_companies = import_from_csv( file, Company )
    if @csv_companies.present?
      @correct_companies = Array.new
        @csv_companies.each do |company|
          if Company.invalid company
            company["error"] = true
          else
            @correct_companies.push company  
          end
        end
       render 'import_from_csv.html.erb'
    else
      redirect_to :back, notice: 'CSV is in invalid format'
    end
  end

  def create_from_list
    companies = params[:companies]
    category = params[:category_select]
    companies.each do |company|
      company = company.slice(:name, :city, :category_id, :lat, :lng, :address)
      company[:category_id] = category
      Company.find_or_create_by! company.to_hash unless Company.invalid company
    end
    redirect_to companies_url, notice: 'Companies were successfully imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit( :name, :city, :category_id, :lat, :lng, :address, :url)
    end
end
