require_relative "../model"

class InvoiceItem < Model
  data_attrs "id", "created_at", "updated_at", "item_id", "invoice_id", "quantity", "unit_price"
end
