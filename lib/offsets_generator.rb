class OffsetsGenerator
  attr_reader :offsets

  def initialize
    @offsets = {A: 0, B: 0, C: 0, D: 0}
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
