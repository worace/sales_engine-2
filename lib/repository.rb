require_relative "model"

class Repository
  attr_reader :root_dir

  def initialize(root_dir)
    @root_dir = root_dir
  end

  def inspect
    "#{self.class.name} with #{entries.count} entries"
  end

  def index(index_name,key,record)
    indices[index_name] = {} unless indices[index_name]
    indices[index_name][key] = [] unless indices[index_name][key]
    indices[index_name][key] << record
  end

  def indices
    @indices ||= {}
  end

  def entries
    @entries ||= load_entries
  end

  def data_file_path
    File.join(root_dir, file_name)
  end

  def load_entries
    rows = CSV.parse(File.read(data_file_path))
    headers = rows.shift
    rows.map do |r|
      m = model.new(Hash[headers.zip(r)])
      m.searchable_attributes.each { |a| index(a,m.send(a),m) }
      m
    end
  end

  def model
    raise "Abstract -- override model"
  end

  def file_name
    raise "Abstract -- override file_name"
  end

  def random
    entries.sample
  end

  def batch_finder(attribute, value)
    entries.select { |i| i.send(attribute) == value }
  end

  def finder(attribute, value)
    entries.find { |i| i.send(attribute) == value }
  end

  def method_missing(method_name, *arguments, &block)
    if method_name.to_s.include?("find_by")
      puts "find by #{finder} with args: #{arguments}"
      attr = method_name.to_s.gsub("find_by_", "")
      finder(attr, arguments[0])
    elsif method_name.to_s.include?("find_all_by_")
      puts "find all by #{finder} with args: #{arguments}"
      attr = method_name.to_s.gsub("find_all_by", "")
      batch_finder(attr, arguments[0])
    else
      super
    end
  end
end

class MerchantRepository < Repository
  def file_name
    "merchants.csv"
  end

  def model
    Merchant
  end
end

class CustomerRepository < Repository
  def file_name
    "customers.csv"
  end

  def find_by_last_name(name)
    indices[:last_name][name].first
  end

  def model
    Customer
  end
end

class InvoiceRepository < Repository
  def file_name
    "invoices.csv"
  end

  def model
    Invoice
  end
end

class TransactionRepository < Repository
  def file_name
    "transactions.csv"
  end

  def model
    Transaction
  end
end

class InvoiceItemRepository < Repository
  def file_name
    "invoice_items.csv"
  end

  def model
    InvoiceItem
  end
end

class ItemRepository < Repository
  def file_name
    "items.csv"
  end

  def model
    Item
  end
end
