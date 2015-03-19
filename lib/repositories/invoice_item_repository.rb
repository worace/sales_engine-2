require_relative "../repository"
require_relative "../models/invoice_item"

class InvoiceItemRepository < Repository
  def file_name
    "invoice_items.csv"
  end

  def model
    InvoiceItem
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_by_item_id(id)
    indices["item_id"][id].first
  end

  def find_all_by_quantity(quantity)
    indices["quantity"][quantity]
  end
end
