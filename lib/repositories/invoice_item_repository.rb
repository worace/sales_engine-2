require_relative "../repository"
require_relative "../models/invoice_item"

class InvoiceItemRepository < Repository
  def file_name
    "invoice_items.csv"
  end

  def model
    InvoiceItem
  end

  def find_by_id(id)
    indices["id"][id].first
  end

  def find_by_item_id(id)
    indices["item_id"][id].first
  end

  def find_all_by_item_id(id)
    indices["item_id"].fetch(id, [])
  end

  def find_all_by_quantity(quantity)
    indices["quantity"][quantity]
  end

  def find_all_by_invoice_id(id)
    indices["invoice_id"][id]
  end

  def create(params)
    ii = InvoiceItem.new({"item_id" => params[:item].id,
                          "invoice_id" => params[:invoice].id,
                          "quantity" => params[:quantity],
                          "unit_price" => params[:item].unit_price,
                          "id" => (entries.last.id + 1),
                          "created_at" => Time.now,
                          "updated_at" => Time.now}, engine)
    entries << ii
    index_entry(ii)
    ii
  end
end
