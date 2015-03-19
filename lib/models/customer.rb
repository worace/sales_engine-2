require_relative "../model"

class Customer < Model
  numeric_attrs "id"
  data_attrs "created_at", "updated_at", "first_name", "last_name"

  def searchable_attributes
    ["first_name", "last_name", "id"]
  end

  def invoices
    engine.invoice_repository.find_all_by_customer_id(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end

  def favorite_merchant
    transactions.group_by(&:merchant).max_by { |merchant, transactions| transactions.count }.first
  end
end
