require_relative "../model"

class Invoice < Model
  numeric_attrs "id", "customer_id", "merchant_id"
  data_attrs "created_at", "updated_at", "status"

  def searchable_attributes
    ["id", "customer_id", "status", "merchant_id"]
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def invoice_items
    engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map(&:item)
  end

  def transactions
    engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def customer
    engine.customer_repository.find_by_id(customer_id)
  end

  def charge(params)
    t_params = {
      "invoice" => self,
      "credit_card_number" => params[:credit_card_number],
      "credit_card_expiration_date" => params[:credit_card_expiration_date],
      "result" => params[:result]
    }
    engine.transaction_repository.create(t_params)
  end

  def successful?
    transactions.any?(&:successful?)
  end

  def revenue
    invoice_items.reduce(0) {|s,ii| s + ii.revenue}
  end

  def date
    Date.parse(created_at)
  end
end
