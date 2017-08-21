class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_layout

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
    @category = Category.new
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @new_sub_category = SubCategory.new
    @sub_categories = @category.sub_categories.all
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_back(fallback_location: :back,alert: "category could not be created") }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
      format.js { render json: { id: @category.id, value: @category.name } }
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        if @category.save
          format.html { redirect_to @category, notice: 'category was successfully created.' }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :edit, alert: 'category could not be updated' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, alert: 'category could not be updated' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def set_layout
      self.class.layout "admin"
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name, :keywords, :featured, images: [])
  end
end
