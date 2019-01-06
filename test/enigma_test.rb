require 'simplecov'
SimpleCov.start
require 'pry'
require 'date'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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

  def test_it_can_encrypt_a_message

    expected = {encryption: "keder ohulw!", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("HELLO WORLD!", "02715", "040895")
  end

  def test_it_can_decrypt_a_message

    expected =  {decryption: "hello world", key: "02715", date: "040895"}
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_has_todays_date

    enigma = mock
    enigma.expects(:todays_date).returns("081819")
    assert_equal "081819", enigma.todays_date
  end

  def test_it_can_encrypt_a_message_using_todays_date

    expected = {encryption: "shhazcsdbo ", key: "02715", date: "010519"}
    enigma = mock
    enigma.stubs(:encrypt).returns(expected)
    assert_equal expected, enigma.encrypt("hello world", "02715")
  end

  def test_it_can_decrypt_a_message_using_todays_date

    expected = {:decryption=>"edhplzssok ", :key=>"02715", :date=>"050119"}
    enigma = mock
    enigma.stubs(:decrypt).returns(expected)
    assert_equal expected, enigma.decrypt("keder ohulw", "02715")
  end

  def test_it_has_a_random_number

    enigma = mock
    enigma.expects(:random_number).returns("62743")
    assert_equal "62743", enigma.random_number
  end


  def test_it_can_generate_random_key_if_not_given_one

    expected = {encryption: "shhazcsdbo ", key: "02715", date: "010519"}
    enigma = mock
    enigma.stubs(:encrypt).returns(expected)
    assert_equal expected, enigma.encrypt("hello world")
  end


end
