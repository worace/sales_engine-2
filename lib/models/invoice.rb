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
    engine.transaction_repository.create("invoice" => self,
                                         "credit_card_number" => params[:credit_card_number],
                                         "credit_card_expiration_date" => params[:credit_card_expiration_date],
                                         "result" => params[:result])
  end

  def successful?
    transactions.any?(&:successful?)
  end
end
