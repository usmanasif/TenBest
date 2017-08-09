class NavLinksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_nav_link, only: [:show, :edit, :update, :destroy]
  before_action :set_layout

  # GET /nav_link
  # GET /nav_link.json
  def index
    @nav_links = NavLink.where(depth: 1).includes(:parent)
    @parents = NavLink.where(depth: 0).includes(:children)
    @new_link = NavLink.new(parent_id: nil, depth: 1)
    flash[:new_alert] = 'not allowed any more active links' unless @new_link.active_count
  end

  # GET /nav_link/1
  # GET /nav_link/1.json
  def show
    @nav_links = @nav_link.children
    @new_link = NavLink.new(parent_id: @nav_link.id, depth: 2)
    flash.now[:new_alert] = 'not allowed any more active links' unless @new_link.active_count
  end

  # GET /nav_link/new
  def new
    @nav_link = NavLink.new
  end

  # GET /nav_link/1/edit
  def edit
    @nav_links = NavLink.all
    @parents = NavLink.where(depth: 0)
    flash.now[:alert] = 'Cannot make this active, already have 5 active links' unless @nav_link.active && @nav_link.active_count
  end

  # POST /nav_link
  # POST /nav_link.json
  def create
    @nav_link = NavLink.new(nav_link_params)
    flash.now[:alert] = 'Cannot make this active, already have 5 active links' unless @nav_link.active && @nav_link.active_count
    respond_to do |format|
      if @nav_link.save
        format.html { redirect_to nav_links_path, notice: 'nav_link was successfully created.' }
        format.json { render :show, status: :created, location: @nav_link }
      else
        format.html { render :new }
        format.json { render json: @nav_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nav_link/1
  # PATCH/PUT /nav_link/1.json
  def update
    respond_to do |format|
      if @nav_link.update(nav_link_params)
        format.html { redirect_to nav_links_path, notice: 'nav_link was successfully updated.' }
        format.json { render :show, status: :ok, location: @nav_link }
      else
        format.html { render :edit }
        format.json { render json: @nav_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_link/1
  # DELETE /nav_link/1.json
  def destroy
    @nav_link.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'nav_link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def nav_link_params
    params.require(:nav_link).permit(:name, :url, :position, :active, :parent_id, :depth)
  end

  def set_layout
    self.class.layout 'admin'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_nav_link
    @nav_link = NavLink.find(params[:id])
  end
end
