class Model
  attr_reader :data, :engine

  def initialize(data, engine)
    @data = data
    @engine = engine
  end

  def id
    data["id"].to_i
  end

  def searchable_attributes
    []
  end

  def self.numeric_attrs(*attr_names)
    attr_names.each do |attr_name|
      define_method(attr_name) do
        data[attr_name].to_i
      end
    end
  end

  def self.data_attrs(*attr_names)
    attr_names.each do |attr_name|
      define_method(attr_name) do
        data[attr_name]
      end
    end
  end
end
