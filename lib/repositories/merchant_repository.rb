require_relative "../repository"
require_relative "../models/merchant"

class MerchantRepository < Repository
  def file_name
    "merchants.csv"
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_by_name(name)
    find_all_by_name(name).first
  end

  def find_all_by_name(name)
    indices["name"].fetch(name, [])
  end

  def model
    Merchant
  end

  def revenue(date)
    engine.invoice_repository.entries.group_by(&:date)[date].select(&:successful?).map(&:revenue).reduce(:+)
  end

  def most_revenue(n)
    entries.sort_by { |m| -m.revenue }.first(n)
  end

  def most_items(n)
    entries.sort_by { |m| -m.quantity_sold }.first(n)
  end
end
