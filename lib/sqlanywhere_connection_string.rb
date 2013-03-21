class SQLAnywhereConnectionString
  attr_accessor :parameters

  def initialize
    self.parameters = {}
  end

  def add(new_parameters)
    self.parameters.merge!(new_parameters)
  end

  def to_s
    self.parameters.map do |parameter_name, parameter_value|
      "#{parameter_name}=#{parameter_value}"
    end.join(';')
  end
end
