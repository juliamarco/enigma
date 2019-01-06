require './lib/shift_generator'

class Enigma < ShiftGenerator
  attr_reader :character_set,
              :shifts

  def initialize
    @character_set = ("a".."z").to_a << " "
    @shifts = {}
    @encrypted = []
  end

  def todays_date
    date = Date.today
    date = date.strftime("%m%d%y")
  end

  def random_number
    number = rand(99999).to_s
    "%05d" % number
  end

  def encrypt(string, key = random_number, date = todays_date)
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

  # def decrypt(string, keys, offsets)
  #   generate_shifts(keys, offsets)
  #   index_hash = sort_char_shift_by_index(string)
  #   decrypted = string.chars.map.with_index do |char, index|
  #     if index_hash[:A].include?(index)
  #       index = @character_set.find_index(char)
  #       rotated = @character_set.rotate(-@shifts[:A])
  #       rotated[index]
  #     elsif index_hash[:B].include?(index)
  #       index = @character_set.find_index(char)
  #       rotated = @character_set.rotate(-@shifts[:B])
  #       rotated[index]
  #     elsif index_hash[:C].include?(index)
  #       index = @character_set.find_index(char)
  #       rotated = @character_set.rotate(-@shifts[:C])
  #       rotated[index]
  #     else index_hash[:D].include?(index)
  #       index = @character_set.find_index(char)
  #       rotated = @character_set.rotate(-@shifts[:D])
  #       rotated[index]
  #     end
  #   end
  #   {decryption: decrypted.join, key: keys, date: offsets}
  # end



end
