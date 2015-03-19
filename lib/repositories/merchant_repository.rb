require_relative "../repository"
require_relative "../models/merchant"

class MerchantRepository < Repository
  def file_name
    "merchants.csv"
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def model
    Merchant
  end
end
