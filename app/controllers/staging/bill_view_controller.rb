require 'ostruct'

class Staging::BillViewController < ApplicationController
  layout "staging/invoice"

  def empty_bill
    @invoice = OpenStruct.new
    @invoice.serial_number = 1
    @invoice.date = DateTime.current

    order = OpenStruct.new
    order.description = "Coffee"
    order.rate = 5.00
    order.quantity = 2
    @invoice.orders = [order]
  end

end
