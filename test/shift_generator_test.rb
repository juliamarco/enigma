require './lib/shift_generator'
require 'minitest/autorun'
require 'minitest/pride'

class ShiftGeneratorTest < MiniTest::Test

  def test_it_exists

    shift_generator = ShiftGenerator.new
    assert_instance_of ShiftGenerator, shift_generator
  end

end
