require_relative "../repository"
require_relative "../models/invoice"

class InvoiceRepository < Repository
  def file_name
    "invoices.csv"
  end

  def model
    Invoice
  end

  def find_all_by_customer_id(cust_id)
    indices["customer_id"][cust_id]
  end
end
