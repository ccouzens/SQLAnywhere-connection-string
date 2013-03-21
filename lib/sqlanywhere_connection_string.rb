class SQLAnywhereConnectionString
  attr_accessor :parameters

  def initialize
    self.parameters = {}
  end

  def add(new_parameters)
    case new_parameters
    when Hash
      self.parameters.merge!(new_parameters)
    when String
      from_s new_parameters
    else
      raise "Parameter type not recognized"
    end
  end

  def to_s
    self.parameters.map do |parameter_name, parameter_value|
      "#{parameter_name}=#{parameter_value}"
    end.join(';')
  end

  def to_hash
    self.parameters
  end

  private
  def from_s connection_string
    key_value_pairs = connection_string.split(';')
    key_value_pairs.each do |key_value_pair|
      key, value = key_value_pair.split('=', 2)
      self.parameters[key.to_sym] = value
    end
  end
end
