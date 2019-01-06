class Enigma
  attr_reader :character_set,
              :shifts

  def initialize
    @character_set = ("a".."z").to_a << " "
    @keys = {A: 0, B: 0, C: 0, D: 0}
    @offsets = {A: 0, B: 0, C: 0, D: 0}
    @shifts = {}
  end

  def generate_keys(number)
    number = number.to_s.split("")
    @keys.each do |letter, num|
      @keys[letter] = number.slice(0..1).join
      number.shift
    end
  end

  def generate_offsets(date)
    date = date.to_i
    number = (date * date).to_s[-4..-1].split("")
    @offsets.each do |letter, num|
      @offsets[letter] = number[0]
      number.shift
    end
  end

  def generate_shifts(key, date)
    generate_keys(key)
    generate_offsets(date)
    @shifts = @keys.merge(@offsets) do |letter, keys_num, offsets_num|
      keys_num.to_i + offsets_num.to_i
    end
  end

  def creates_hash_with_index_for_each_shift(string)
    index_hash = { A: [], B: [], C: [], D: [] }
    first_index = 0
    all_indexes = (first_index..string.length).to_a
    index_hash.each do |k,v|
      all_indexes.each do |num|
        index_hash[k] << num
        3.times {all_indexes.shift}
      end
      first_index += 1
      all_indexes = (first_index..string.length).to_a
    end
    return index_hash
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
    # binding.pry
    generate_shifts(key, date)
    index_hash = creates_hash_with_index_for_each_shift(string)
    encrypted = string.chars.map.with_index do |char, index|
      if index_hash[:A].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(@shifts[:A])
        rotated[index]
      elsif index_hash[:B].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(@shifts[:B])
        rotated[index]
      elsif index_hash[:C].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(@shifts[:C])
        rotated[index]
      else index_hash[:D].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(@shifts[:D])
        rotated[index]
      end
    end
    {encryption: encrypted.join, key: key, date: date}
  end

  def decrypt(string, keys, offsets)
    generate_shifts(keys, offsets)
    index_hash = creates_hash_with_index_for_each_shift(string)
    decrypted = string.chars.map.with_index do |char, index|
      if index_hash[:A].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(-@shifts[:A])
        rotated[index]
      elsif index_hash[:B].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(-@shifts[:B])
        rotated[index]
      elsif index_hash[:C].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(-@shifts[:C])
        rotated[index]
      else index_hash[:D].include?(index)
        index = @character_set.find_index(char)
        rotated = @character_set.rotate(-@shifts[:D])
        rotated[index]
      end
    end
    {decryption: decrypted.join, key: keys, date: offsets}
  end



end
