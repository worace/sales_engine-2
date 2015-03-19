require_relative "../model"

class Transaction < Model
  numeric_attrs "id", "invoice_id"
  data_attrs "created_at", "updated_at", "credit_card_number", "credit_card_expiration_date", "result"

  def invoice
    engine.invoice_repository.find_by_id(invoice_id)
  end

  def merchant
    invoice.merchant
  end

  def searchable_attributes
    ["id", "invoice_id", "credit_card_number", "result"]
  end

  def successful?
    result == "success"
  end
end
