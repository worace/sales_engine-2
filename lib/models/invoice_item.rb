require_relative "../model"
require "bigdecimal"

class InvoiceItem < Model
  numeric_attrs "id", "item_id", "invoice_id", "quantity"
  data_attrs "created_at", "updated_at", "unit_price"

  def searchable_attributes
    ["id", "item_id", "invoice_id", "quantity"]
  end

  def unit_price
    BigDecimal.new(data["unit_price"])
  end

  def item
    engine.item_repository.find_by_id(item_id)
  end

  def invoice
    engine.invoice_repository.find_by_id(invoice_id)
  end

  def successful?
    invoice.successful?
  end

  def revenue
    quantity * unit_price/100
  end
end
