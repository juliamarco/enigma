require './lib/shift_generator'
require 'date'

class Enigma < ShiftGenerator
  attr_reader :character_set

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def encrypt(string, key = 0, date = todays_date)
    string = string.downcase
    generate_shifts(key, date)
    encrypted = []
    index_hash = sort_char_shift_by_index(string)
    encrypted = encrypt_normal_characters(string, index_hash, encrypted)
    encrypted = ignore_special_characters(string, encrypted)
    {encryption: encrypted.join, key: key, date: date}
  end

  def encrypt_normal_characters(string, index_hash, encrypted)
    string.chars.each_with_index do |char, index|
      index_hash.each do |letter, idx|
        if @character_set.include?(char)
          if index_hash[letter].include?(index)
            encrypted = build_encrypted_message(letter, char, encrypted)
          end
        end
      end
    end
    return encrypted
  end

  def build_encrypted_message(letter_shift, char, encrypted)
    index = @character_set.find_index(char)
    rotated = @character_set.rotate(@shifts[letter_shift])
    encrypted << rotated[index]
  end

  def ignore_special_characters(string, encrypted)
    string.chars.each_with_index do |char, index|
      unless @character_set.include?(char)
        encrypted.insert(index, char)
      end
    end.join
    return encrypted
  end

  def decrypt(string, keys, offsets = todays_date)
    decrypted = []
    generate_shifts(keys, offsets)
    index_hash = sort_char_shift_by_index(string)
    string.chars.each_with_index do |char, index|
      index_hash.each do |letter, idx|
        if @character_set.include?(char)
          if index_hash[letter].include?(index)
            build_decrypted_message(letter, char, decrypted)
          end
        end
      end
    end
    {decryption: decrypted.join, key: keys, date: offsets}
  end

  def build_decrypted_message(letter_shift, char, decrypted)
    index = @character_set.find_index(char)
    rotated = @character_set.rotate(-@shifts[letter_shift])
    decrypted << rotated[index]
  end

  def find_possible_keys
    (0..99999).to_a.map do |num|
      "%05d" % num.to_s
    end
  end

  def crack(encrypted_message, date = todays_date)
    possible_keys = find_possible_keys
    cracked_key = possible_keys.find do |possible_key|
      decrypted = decrypt(encrypted_message, possible_key, date)
      decrypted[:decryption][-4..-1] == " end"
    end
    decrypted = []
    decrypt(encrypted_message, cracked_key, date)
  end

end
