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
    indices["invoice_id"].fetch(id, [])
  end

  def create(params)
    t = Transaction.new({"invoice_id" => params["invoice"].id,
                        "credit_card_expiration_date" => params["credit_card_expiration_date"],
                        "credit_card_number" => params["credit_card_number"],
                        "result" => params["result"]},engine)

    entries << t
    index_entry(t)
    t
  end
end
