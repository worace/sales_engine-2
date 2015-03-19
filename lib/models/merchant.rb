require_relative "../model"

class Merchant < Model
  numeric_attrs "id"
  data_attrs "created_at", "updated_at", "name"

  def searchable_attributes
    ["id", "name"]
  end

  def items
    engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def revenue(date=nil)
    if date
      rev_by_date(date)
    else
      all_revenue
    end
  end

  def rev_by_date(date)
    invoices.group_by(&:date)[date].select do |i|
      i.successful?
    end.map(&:revenue).reduce(:+)
  end

  def all_revenue
    invoices.select(&:successful?).map(&:revenue).reduce(:+)
  end

  def quantity_sold
    invoices.select(&:successful?).flat_map do |i|
      i.invoice_items
    end.map(&:quantity).reduce(:+)
  end

  def favorite_customer
    cust_id = invoices.select(&:successful?).group_by do |i|
      i.customer_id
    end.max_by do |id,invoices|
                invoices.count
              end.first
    engine.customer_repository.find_by_id(cust_id)
  end

  def customers_with_pending_invoices
    invoices.reject(&:successful?).map(&:customer)
  end
end
