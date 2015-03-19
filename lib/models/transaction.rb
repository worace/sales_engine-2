require_relative "../model"

class Transaction < Model
  data_attrs "id", "created_at", "updated_at", "invoice_id", "credit_card_number", "credit_card_expiration_date", "result"
end
