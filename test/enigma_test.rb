require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < MiniTest::Test

  def test_it_exists

    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_has_a_character_test

    enigma = Enigma.new
    character_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal character_set, enigma.character_set
  end

end
