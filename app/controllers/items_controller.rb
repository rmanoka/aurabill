class ItemsController < ApplicationController
  respond_to :html
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = Item.all
    @items = @items.starts_with(params[:starts_with]) if params[:starts_with].present?
    respond_with(@items)
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(@item)
  end

  def show
    respond_with(@item)
  end




  
  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params[:item]
    end

end
