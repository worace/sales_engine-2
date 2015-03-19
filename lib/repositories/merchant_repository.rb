require_relative "../repository"
require_relative "../models/merchant"

class MerchantRepository < Repository
  def file_name
    "merchants.csv"
  end

  def model
    Merchant
  end
end
