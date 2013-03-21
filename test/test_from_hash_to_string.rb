require 'test/unit'
require_relative '../lib/sqlanywhere_connection_string'

class TestFromHashToString < Test::Unit::TestCase
	def test_empty_hash
    cs = SQLAnywhereConnectionString.new
    cs.add({})
    assert_equal("", cs.to_s)
	end

  def test_multiple_parameters
    cs = SQLAnywhereConnectionString.new
    cs.add({
      Server: 'demo12',
      DBN: 'demo',
      UID: 'DBA',
      PWD: 'sql',
      })
    assert_equal("Server=demo12;DBN=demo;UID=DBA;PWD=sql", cs.to_s)
  end

  def test_backslashes
    cs = SQLAnywhereConnectionString.new
    cs.add({
      UID: 'back\slash',
      })
    assert_equal('UID=back\slash', cs.to_s)
  end

  def test_semicolons
    cs = SQLAnywhereConnectionString.new
    cs.add({
      UID: 'semi;colon',
      })
    assert_equal('UID=semi;colon', cs.to_s)
  end
end
