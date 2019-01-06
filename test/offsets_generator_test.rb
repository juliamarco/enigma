require './lib/offsets_generator'
require 'minitest/autorun'
require 'minitest/pride'

class OffsetsGeneratorTest < MiniTest::Test

  def test_it_exists

    offsets = OffsetsGenerator.new
    assert_instance_of OffsetsGenerator, offsets
  end

  def test_it_starts_with_no_offsets

    offsets = OffsetsGenerator.new
    expected = {A: 0, B: 0, C: 0, D: 0}
    assert_equal expected, offsets.offsets
  end

end
