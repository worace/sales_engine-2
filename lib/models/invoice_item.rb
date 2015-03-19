require_relative "../model"

class InvoiceItem < Model
  numeric_attrs "id", "item_id", "invoice_id", "quantity"
  data_attrs "created_at", "updated_at", "unit_price"

  def searchable_attributes
    ["id", "item_id", "invoice_id", "quantity"]
  end

  def item
    engine.item_repository.find_by_id(item_id)
  end

  def invoice
    engine.invoice_repository.find_by_id(invoice_id)
  end
end
