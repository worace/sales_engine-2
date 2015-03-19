require_relative "../model"

class Invoice < Model
  numeric_attrs "id", "customer_id", "merchant_id"
  data_attrs "created_at", "updated_at", "status"

  def searchable_attributes
    ["customer_id"]
  end
end
