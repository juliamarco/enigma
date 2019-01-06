require './lib/offsets_generator'
require 'minitest/autorun'
require 'minitest/pride'

class OffsetsGeneratorTest < MiniTest::Test

  def test_it_exists

    offsets = OffsetsGenerator.new
    assert_instance_of OffsetsGenerator, offsets
  end

end
