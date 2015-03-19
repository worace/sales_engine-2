require_relative "../model"

class Merchant < Model
  numeric_attrs "id"
  data_attrs "created_at", "updated_at", "name"

  def searchable_attributes
    ["id", "name"]
  end

  def items
    engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    engine.invoice_repository.find_all_by_merchant_id(id)
  end
end
