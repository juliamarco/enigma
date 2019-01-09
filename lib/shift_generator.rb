require './lib/keys_generator'
require './lib/offsets_generator'
require 'pry'

class ShiftGenerator
  attr_accessor :shifts

  def initialize
    @shifts = {}
  end

  def generate_shifts(number, date)
    keys = KeysGenerator.new(number)
    keys.generate_keys(number)
    offsets = OffsetsGenerator.new(date)
    @shifts = keys.keys.merge(offsets.offsets) do |letter, keys_num, offsets_num|
      keys_num.to_i + offsets_num.to_i
    end
  end

  def sort_char_shift_by_index(message)
    index_hash = { A: [], B: [], C: [], D: [] }
    first_index = 0
    all_indexes = (first_index..message.length).to_a
    index_hash.each do |letter,index|
      all_indexes.each do |num|
        index_hash[letter] << num
        3.times {all_indexes.shift}
      end
      first_index += 1
      all_indexes = (first_index..message.length).to_a
    end
    return index_hash
  end

end
