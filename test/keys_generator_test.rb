require './lib/keys_generator'
require 'minitest/autorun'
require 'minitest/pride'

class KeysGeneratorTest < MiniTest::Test

  def test_it_exists
    keys = KeysGenerator.new("02715")

    assert_instance_of KeysGenerator, keys
  end

  def test_it_can_generate_keys

    keys = KeysGenerator.new("02715")
    expected = {A: "02", B: "27", C: "71", D: "15"}
    assert_equal expected, keys.keys
  end

end
