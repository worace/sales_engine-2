require_relative "model"

class Repository
  attr_reader :root_dir, :engine

  def initialize(root_dir, engine)
    @root_dir = root_dir
    @engine = engine
  end

  def inspect
    "#{self.class.name} with #{entries.count} entries"
  end

  def index(index_name,key,record)
    indices[index_name] = {} unless indices[index_name]
    indices[index_name][key] = [] unless indices[index_name][key]
    indices[index_name][key] << record
  end

  def index_entry(entry)
    entry.searchable_attributes.each { |a| index(a,entry.send(a),entry) }
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
      m = model.new(Hash[headers.zip(r)], engine)
      index_entry(m)
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
end
