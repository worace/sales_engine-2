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

  def invoice_items
    engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def invoices
    invoice_items.map(&:invoice)
  end

  def merchant
    engine.merchant_repository.find_by_id(merchant_id)
  end

  def revenue
    invoice_items.select(&:successful?).reduce(0) { |s,ii| s + ii.revenue }
  end

  def quantity_sold
    invoice_items.select(&:successful?).reduce(0) { |s,ii| s + ii.quantity }
  end

  def best_day
    invoice_items.select(&:successful?).group_by do |ii|
      Date.parse(ii.invoice.created_at)
    end.max_by do |date, iis|
      iis.count
    end.first
  end
end
