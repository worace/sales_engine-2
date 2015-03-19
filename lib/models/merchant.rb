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
    invoices.group_by(&:date)[date].select(&:successful?).map(&:revenue).reduce(:+)
  end

  def all_revenue
    invoices.select(&:successful?).map(&:revenue).reduce(:+)
  end

  def quantity_sold
    invoices.select(&:successful?).flat_map(&:invoice_items).map(&:quantity).reduce(:+)
  end
end
