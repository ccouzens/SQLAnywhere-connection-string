require_relative '../sqlanywhere_connection_string'

# This class is intended to pass ActiveRecord connection parameters,
# such as those found in database yml files.
class SQLAnywhereConnectionString::ActiveRecord
  attr_accessor :connection_string

  def initialize
    self.connection_string = SQLAnywhereConnectionString.new
  end

  def add(parameters)
    parameters.each do |key, value|
      case key.to_sym
      when :database
        self.connection_string.add(DBN: value)
      when :server
        self.connection_string.add(Server: value)
      when :username
        self.connection_string.add(UID: value)
      when :password
        self.connection_string.add(PWD: value)
      when :encoding
        self.connection_string.add(CS: value)
      when :connection_string
        self.connection_string.add(value)
      else
        self.connection_string.add({key => value})
      end
    end
  end

  def pop_username
    parameters = self.connection_string.parameters
    user_id = parameters.delete(:Userid)
    uid = parameters.delete(:UID)
    user_id || uid
  end

  def pop_password
    parameters = self.connection_string.parameters
    password = parameters.delete(:Password)
    pwd = parameters.delete(:PWD)
    password || pwd
  end

  def add_defaults
    database = self.connection_string.parameters.fetch(:DBN)
    if database
      self.add(server: database)
    end
    self.add({
      username: 'DBA',
      password: 'sql',
      encoding: 'UTF-8',
      Idle: '0',
      })
  end

  def to_s
    self.connection_string.to_s
  end

end
