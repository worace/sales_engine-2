require_relative "../repository"
require_relative "../models/item"

class ItemRepository < Repository
  def file_name
    "items.csv"
  end

  def model
    Item
  end

  def find_by_id(id)
    indices["id"][id].first
  end
end
