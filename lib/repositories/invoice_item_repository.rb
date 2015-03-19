require_relative "../repository"
require_relative "../models/invoice_item"

class InvoiceItemRepository < Repository
  def file_name
    "invoice_items.csv"
  end

  def model
    InvoiceItem
  end
end
