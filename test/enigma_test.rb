require 'simplecov'
SimpleCov.start
require 'pry'
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

    todays_date = Date.today.strftime("%m%d%y")
    assert_equal todays_date, @enigma.todays_date
  end

  def test_it_has_a_random_number

    num = @enigma.random_number
    nums = @enigma.find_possible_keys
    assert nums.include?(num)
  end

  def test_it_can_encrypt_a_message_using_todays_date

    expected = {encryption: "shhazcsdbo ", key: "02715", date: "010519"}

    @enigma.stubs(:todays_date).returns("010519")
    @enigma.stubs(:random_number).returns("02715")
    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_encrypt_normal_characters

    string = "hello world"
    key = "02715"
    date = "040895"
    expected = ["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"]
    shifts = @enigma.generate_shifts(key, date)
    index_hash = @enigma.sort_char_shift_by_index(string)

    assert_equal expected, @enigma.encrypt_normal_characters(string, index_hash, [])
  end

  def test_it_can_ignore_special_characters

    date = "010819"
    string = "hello world!"
    key = "02715"
    encrypted = @enigma.encrypt(string, key, date)
    assert_equal encrypted[:encryption], @enigma.ignore_special_characters("jlhaqgsdts !", encrypted[:encryption])
  end

  def test_it_can_build_encrypted_message

    letter = :A
    char = "h"
    @shifts = @enigma.generate_shifts("02715", "040895")
    assert_equal ["k"], @enigma.build_encrypted_message(letter, char, [])
  end

  def test_it_can_decrypt_a_message_using_todays_date

    expected = {:decryption=>"fdhpmzsspk ", :key=>"02715", :date=>"010619"}
    enigma = mock
    enigma.stubs(:decrypt).returns(expected)
    assert_equal expected, enigma.decrypt("keder ohulw", "02715")
  end

  def test_it_can_build_decrypted_message

    letter = :A
    char = "h"
    @shifts = @enigma.generate_shifts("02715", "040895")
    assert_equal ["e"], @enigma.build_decrypted_message(letter, char, [])
  end

  def test_it_can_find_possible_keys

    expected = ["00000", "00001", "00002", "00003", "00004", "00005", "00006", "00007", "00008", "00009", "00010"]
    enigma = mock
    enigma.stubs(:find_possible_keys).returns(expected)
    assert_equal expected, enigma.find_possible_keys
  end

  def test_it_can_generate_random_key_if_not_given_one

    expected = {encryption: "shhazcsdbo ", key: "02715", date: "010519"}
    enigma = mock
    enigma.stubs(:encrypt).returns(expected)
    assert_equal expected, enigma.encrypt("hello world")
  end

  def test_it_can_crack_an_encryption_with_a_date

    encrypted = @enigma.encrypt("hello world end", "00304", "291018")

    expected = {decryption: "hello world end", date: "291018", key: "00304"}
    assert_equal expected, @enigma.crack(encrypted[:encryption],encrypted[:date])
  end

  def test_it_can_crack_an_encryption_using_todays_date

    encrypted = @enigma.encrypt("hello world end", "00304", "291018")

    expected = {decryption: "hello world end", key: "00304", date: "291018"}
    @enigma.stubs(:todays_date).returns("291018")

    assert_equal expected, @enigma.crack(encrypted[:encryption])
  end

end
