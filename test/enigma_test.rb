require 'simplecov'
SimpleCov.start
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < MiniTest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists

    assert_instance_of Enigma, @enigma
  end

  def test_it_has_a_character_test

    character_set = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal character_set, @enigma.character_set
  end

  def test_it_can_generate_keys

    expected = {A: "02", B: "27", C: "71", D: "15"}
    assert_equal expected, @enigma.generate_keys("02715")
  end


  def test_it_can_generate_offsets

    expected = {A: "1", B: "0", C: "2", D: "5"}
    assert_equal expected, @enigma.generate_offsets("040895")
  end

  def test_it_starts_with_no_shifts

    expected = {}
    assert_equal expected, @enigma.shifts
  end

  def test_it_can_generate_shifts

    @enigma.generate_keys("02715")
    @enigma.generate_offsets("040895")

    @enigma.generate_shifts

    expected = {A: 3, B: 27, C: 73, D: 20}
    assert_equal expected, @enigma.shifts
  end

end
