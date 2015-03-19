require "bigdecimal"
require_relative "../model"

class Item < Model
  numeric_attrs "id", "merchant_id"
  data_attrs "created_at", "updated_at", "name", "description"

  def searchable_attributes
    ["id", "merchant_id", "string_price", "name"]
  end

  def string_price
    unit_price.to_s
  end

  def unit_price
    BigDecimal.new(data["unit_price"])/100
  end
end
