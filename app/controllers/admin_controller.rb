class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @pronoun_orders = PronounOrder.all
    @companies = Company.all
  end
end
