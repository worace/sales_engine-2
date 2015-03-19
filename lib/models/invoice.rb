require_relative "../model"

class Invoice < Model
  numeric_attrs "id", "customer_id", "merchant_id"
  data_attrs "created_at", "updated_at", "status"

  def searchable_attributes
    ["id", "customer_id", "status"]
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def invoice_items
    engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map(&:item)
  end

  def transactions
    engine.transaction_repository.find_all_by_invoice_id(id)
  end
end
