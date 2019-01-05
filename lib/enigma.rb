require 'date'

class Enigma
  attr_reader :character_set,
              :keys,
              :offsets

  def initialize
    @character_set = ("a".."z").to_a << " "
    @keys = {A: 0, B: 0, C: 0, D: 0}
    @offsets = {A: 0, B: 0, C: 0, D: 0}
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


end
