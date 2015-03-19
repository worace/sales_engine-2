require_relative "../repository"
require_relative "../models/customer"

class CustomerRepository < Repository
  def file_name
    "customers.csv"
  end

  def find_by_last_name(name)
    indices["last_name"][name].first
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_all_by_first_name(name)
    indices["first_name"][name]
  end

  def model
    Customer
  end
end
