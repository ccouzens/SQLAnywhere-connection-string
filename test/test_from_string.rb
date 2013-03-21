require 'test/unit'
require_relative '../lib/sqlanywhere_connection_string'

class TestFromString < Test::Unit::TestCase
  def test_empty_string
    cs = SQLAnywhereConnectionString.new
    cs.add("")
    assert_equal({}, cs.to_hash)
  end

  def test_multiple_parameters
    cs = SQLAnywhereConnectionString.new
    cs.add("Server=demo12;DBN=demo;UID=DBA;PWD=sql")
    h = {
      Server: 'demo12',
      DBN: 'demo',
      UID: 'DBA',
      PWD: 'sql',
      }
    assert_equal(h, cs.to_hash)
  end

  def test_later_adds_override
    cs = SQLAnywhereConnectionString.new
    cs.add("Server=demo12")
    cs.add("Server=demo13")
    assert_equal('Server=demo13', cs.to_s)
  end

  def test_later_adds_merge
    cs = SQLAnywhereConnectionString.new
    cs.add("UID=dba")
    cs.add("PWD=sql")
    assert_equal('UID=dba;PWD=sql', cs.to_s)
  end

end
