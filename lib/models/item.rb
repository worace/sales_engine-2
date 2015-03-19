require_relative "../model"

class Item < Model
  data_attrs "id", "created_at", "updated_at", "name", "description", "unit_price", "merchant_id"
end
