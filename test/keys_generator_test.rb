require './lib/keys_generator'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class KeysGeneratorTest < MiniTest::Test

  def test_it_exists
    keys = KeysGenerator.new("02715")

    assert_instance_of KeysGenerator, keys
  end

  def test_it_can_generate_keys
    number = "02715"
    key = KeysGenerator.new(number)
    key.generate_keys(number)
    expected = {A: "02", B: "27", C: "71", D: "15"}
    assert_equal expected, key.keys
  end

  def test_it_has_a_random_number

    key = KeysGenerator.new(0)

    num = key.random_number
    all_possible_numbers = (0..99999).to_a.map {|num| "%05d" % num.to_s}
    assert all_possible_numbers.include?(num)
  end

  def test_it_can_assign_num_to_letters

    number = "02715"
    key = KeysGenerator.new(number)
    key.generate_keys(number)

    expected = {:A=>"02", :B=>"27", :C=>"71", :D=>"15"}
    assert_equal expected, key.assign_num_to_letters("02715")
  end


end
