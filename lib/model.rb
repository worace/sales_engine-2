class Model
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def searchable_attributes
    []
  end

  def self.data_attrs(*attr_names)
    attr_names.each do |attr_name|
      define_method(attr_name) do
        data[attr_name]
      end
    end
  end
end

class Item < Model
  data_attrs "id", "created_at", "updated_at", "name", "description", "unit_price", "merchant_id"
end

class Customer < Model
  data_attrs "id", "created_at", "updated_at", "first_name", "last_name"

  def searchable_attributes
    ["first_name", "last_name"]
  end
end

class Merchant < Model
  data_attrs "id", "created_at", "updated_at", "name"
end

class InvoiceItem < Model
  data_attrs "id", "created_at", "updated_at", "item_id", "invoice_id", "quantity", "unit_price"
end

class Invoice < Model
  data_attrs "id", "created_at", "updated_at", "customer_id", "merchant_id", "status"
end

class Transaction < Model
  data_attrs "id", "created_at", "updated_at", "invoice_id", "credit_card_number", "credit_card_expiration_date", "result"
end
