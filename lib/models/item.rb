require_relative "../model"

class Item < Model
  numeric_attrs "id", "merchant_id"
  data_attrs "created_at", "updated_at", "name", "description", "unit_price"

  def searchable_attributes
    ["id", "merchant_id"]
  end
end
