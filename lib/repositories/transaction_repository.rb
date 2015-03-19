require_relative "../repository"
require_relative "../models/transaction"

class TransactionRepository < Repository
  def file_name
    "transactions.csv"
  end

  def model
    Transaction
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_all_by_invoice_id(id)
    indices["invoice_id"].fetch(id, [])
  end

  def find_all_by_result(res)
    indices["result"].fetch(res, [])
  end

  def find_by_credit_card_number(num)
    indices["credit_card_number"][num].first
  end

  def create(params)
    t = Transaction.new({"invoice_id" => params["invoice"].id,
                        "credit_card_expiration_date" => params["credit_card_expiration_date"],
                        "credit_card_number" => params["credit_card_number"],
                        "result" => params["result"],
                        "created_at" => Time.now.to_s,
                        "updated_at" => Time.now.to_s},engine)

    entries << t
    index_entry(t)
    t
  end
end
