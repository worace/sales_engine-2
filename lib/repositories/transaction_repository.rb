require_relative "../repository"
require_relative "../models/transaction"

class TransactionRepository < Repository
  def file_name
    "transactions.csv"
  end

  def model
    Transaction
  end
end
