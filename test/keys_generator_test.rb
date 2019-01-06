require './lib/keys_generator'
require 'minitest/autorun'
require 'minitest/pride'

class KeysGeneratorTest < MiniTest::Test

  def test_it_exists
    keys = KeysGenerator.new

    assert_instance_of KeysGenerator, keys
  end

end
