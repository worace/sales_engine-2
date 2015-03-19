require_relative "../repository"
require_relative "../models/transaction"

class TransactionRepository < Repository
  def file_name
    "transactions.csv"
  end

  def model
    Transaction
  end

  def find_all_by_invoice_id(id)
    indices["invoice_id"][id]
  end
end
