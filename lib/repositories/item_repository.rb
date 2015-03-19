require_relative "../repository"
require_relative "../models/item"

class ItemRepository < Repository
  def file_name
    "items.csv"
  end

  def model
    Item
  end
end
