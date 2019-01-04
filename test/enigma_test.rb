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

end
