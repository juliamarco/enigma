require './lib/shift_generator'
require 'minitest/autorun'
require 'minitest/pride'

class ShiftGeneratorTest < MiniTest::Test

  def test_it_exists

    shift_generator = ShiftGenerator.new
    assert_instance_of ShiftGenerator, shift_generator
  end

  def test_it_starts_with_no_shifts

    shift_generator = ShiftGenerator.new
    expected = {}
    assert_equal expected, shift_generator.shifts
  end

  def test_it_can_generate_shifts

    shift_generator = ShiftGenerator.new
    shift_generator.generate_shifts("02715", "040895")
    expected = {A: 3, B: 27, C: 73, D: 20}
    assert_equal expected, shift_generator.shifts
  end

  def test_it_can_sort_character_shift_by_index

    shift_generator = ShiftGenerator.new
    string = "hello world"
    expected = {:A=>[0, 4, 8], :B=>[1, 5, 9], :C=>[2, 6, 10], :D=>[3, 7, 11]}
    assert_equal expected, shift_generator.sort_char_shift_by_index(string)
  end


end
