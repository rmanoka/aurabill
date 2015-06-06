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
    if (@item.sub_items.length == 0) 
      invoice_id = session[:current_invoice_id]
      @invoice = Invoice.where(id: invoice_id).first
      redirect_to root_path
    else
      respond_with(@item)
    end
  end




  
  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params[:item]
    end

end
