require 'test/unit'
require_relative '../lib/sqlanywhere_connection_string/active_record'

class TestFromActiveRecordHash < Test::Unit::TestCase
  def test_empty_hash
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    ar.add({})
    assert_equal("", ar.to_s)
  end

  def test_parameters_are_renamed
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    ar.add({
      database: 'demo',
      server: 'demo12',
      username: 'DBA',
      password: 'sql',
      encoding: 'UTF-8',
      })
    cs = "DBN=demo;Server=demo12;UID=DBA;PWD=sql;CS=UTF-8"
    assert_equal(cs, ar.to_s)
  end

  def test_pop_username
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    ar.add({ username: 'DBA' })
    assert_equal("DBA", ar.pop_username)
    assert_equal(nil, ar.pop_username)
    assert_equal('', ar.to_s)
  end

  def test_pop_password
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    ar.add({ password: 'sql' })
    assert_equal("sql", ar.pop_password)
    assert_equal(nil, ar.pop_password)
    assert_equal('', ar.to_s)
  end

  def test_add_defaults
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    ar.add({database: 'demo'})
    ar.add_defaults
    hash = {
      DBN: 'demo',
      Server: 'demo',
      UID: 'DBA',
      PWD: 'sql',
      CS: 'UTF-8',
      Idle: '0',
    }
    assert_equal(hash, ar.connection_string.to_hash)
  end

  def test_defaults_do_not_overwrite
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    hash = {
      DBN: 'demo',
      Server: 'emod',
      UID: 'ABD',
      PWD: 'lqs',
      CS: 'windows-1252',
      Idle: '20',
    }
    ar.add(hash)
    ar.add_defaults
    assert_equal(hash, ar.connection_string.to_hash)
  end

  def test_add_connection_string
    ar = SQLAnywhereConnectionString::ActiveRecord.new
    cs = "Server=demo12;DBN=demo;UID=DBA;PWD=sql"
    ar.add({connection_string: cs})
    assert_equal(cs, ar.to_s)
  end

end
