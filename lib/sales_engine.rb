require "csv"
Dir.glob(File.join(__dir__, "repositories", "*")) {|file| require file}

class SalesEngine
  REPOSITORIES = {:merchant_repository => MerchantRepository,
                  :item_repository => ItemRepository,
                  :invoice_repository => InvoiceRepository,
                  :customer_repository => CustomerRepository,
                  :transaction_repository => TransactionRepository,
                  :invoice_item_repository => InvoiceItemRepository}

  attr_reader :repositories, :root_dir
  def initialize(root_dir)
    @root_dir = root_dir
  end

  def startup
    @repositories = REPOSITORIES.reduce({}) do |car, repo|
                      repo_name, repo_class = repo
                      car[repo_name] = repo_class.new(root_dir, self)
                      car[repo_name].entries
                      car
                    end
  end

  REPOSITORIES.keys.each do |repo|
    define_method(repo) do
      @repositories[repo]
    end
  end
end
