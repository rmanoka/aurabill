class InvoicesController < ApplicationController
    respond_to :html
    before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  
    def index
        @invoices = Invoice.all
        @invoices = @invoices.starts_with(params[:starts_with]) if params[:starts_with].present?
        respond_with(@invoices)
    end 

    def show
        respond_with(@invoice)
    end

    def new
        @invoice = Invoice.create
        session[:current_invoice] = @invoice.id
        respond_with(@invoice)
    end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def item_params
      params[:invoice]
    end


end
