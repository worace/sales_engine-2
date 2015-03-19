require_relative "../model"

class Merchant < Model
  numeric_attrs "id"
  data_attrs "created_at", "updated_at", "name"

  def searchable_attributes
    ["id"]
  end
end
