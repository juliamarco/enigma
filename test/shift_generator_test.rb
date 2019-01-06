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

end
