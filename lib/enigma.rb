require './lib/shift_generator'

class Enigma < ShiftGenerator
  attr_reader :character_set,
              :shifts

  def initialize
    @character_set = ("a".."z").to_a << " "
    @encrypted = []
    @decrypted = []
  end

  def todays_date
    date = Date.today
    date = date.strftime("%m%d%y")
  end

  def random_number
    number = rand(99999)
  end

  def encrypt(string, key = "%05d" % random_number.to_s, date = todays_date)
    string = string.downcase
    generate_shifts(key, date)
    index_hash = sort_char_shift_by_index(string)
    encrypt_normal_characters(string, index_hash)
    ignore_special_characters(string)
    {encryption: @encrypted.join, key: key, date: date}
  end

  def encrypt_normal_characters(string, index_hash)
    string.chars.each_with_index do |char, index|
      index_hash.each do |letter, idx|
        if @character_set.include?(char)
          if index_hash[letter].include?(index)
            build_encrypted_message(letter, char)
          end
        end
      end
    end
  end

  def build_encrypted_message(letter_shift, char)
    index = @character_set.find_index(char)
    rotated = @character_set.rotate(@shifts[letter_shift])
    @encrypted << rotated[index]
  end

  def ignore_special_characters(string)
    string.chars.each_with_index do |char, index|
      unless @character_set.include?(char)
        @encrypted.insert(index, char)
      end
    end
  end

  def decrypt(string, keys, offsets = todays_date)
    generate_shifts(keys, offsets)
    index_hash = sort_char_shift_by_index(string)
    string.chars.each_with_index do |char, index|
      index_hash.each do |letter, idx|
        if @character_set.include?(char)
          if index_hash[letter].include?(index)
            build_decrypted_message(letter, char)
          end
        end
      end
    end
    {decryption: @decrypted.join, key: keys, date: offsets}
  end

  def build_decrypted_message(letter_shift, char)
    index = @character_set.find_index(char)
    rotated = @character_set.rotate(-@shifts[letter_shift])
    @decrypted << rotated[index]
  end


end
