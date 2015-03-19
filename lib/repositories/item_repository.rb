require_relative "../repository"
require_relative "../models/item"

class ItemRepository < Repository
  def file_name
    "items.csv"
  end

  def model
    Item
  end

  def find_by_name(name)
    indices["name"][name].first
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_by_unit_price(price)
    indices["string_price"].fetch(price.to_s,[]).first
  end

  def find_all_by_name(name)
    indices["name"].fetch(name,[])
  end

  def most_revenue(n)
    entries.sort_by { |i| -i.revenue }.first(n)
  end

  def most_items(n)
    entries.sort_by { |i| -i.quantity_sold }.first(n)
  end
end
