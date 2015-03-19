require_relative "../repository"
require_relative "../models/invoice"

class InvoiceRepository < Repository
  def file_name
    "invoices.csv"
  end

  def model
    Invoice
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_all_by_customer_id(cust_id)
    indices["customer_id"][cust_id]
  end

  def find_all_by_merchant_id(merchant_id)
    indices["merchant_id"][merchant_id]
  end

  def find_by_status(status)
    indices["status"].fetch(status, []).first
  end

  def find_all_by_status(status)
    indices["status"][status]
  end

  def create(params)
    i = Invoice.new({"customer_id" => params[:customer].id,
                    "merchant_id" => params[:merchant].id,
                    "id" => (entries.last.id + 1),
                    "created_at" => Time.now,
                    "updated_at" => Time.now}, engine)
    entries << i
    index_entry(i)
    params[:items].each do |item|
      engine.invoice_item_repository.create(item: item,
                                            invoice: i,
                                            quantity: 1)

    end
    i
  end
end
