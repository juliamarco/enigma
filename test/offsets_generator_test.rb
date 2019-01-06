require './lib/offsets_generator'
require 'minitest/autorun'
require 'minitest/pride'

class OffsetsGeneratorTest < MiniTest::Test

  def test_it_exists

    offsets = OffsetsGenerator.new("040895")
    assert_instance_of OffsetsGenerator, offsets
  end

  def test_it_can_generate_offsets

    offsets = OffsetsGenerator.new("040895")
    expected = {A: "1", B: "0", C: "2", D: "5"}
    assert_equal expected, offsets.offsets
  end


end
