class KeysGenerator
  attr_reader :keys

  def initialize
    @keys = {A: 0, B: 0, C: 0, D: 0}
  end

  def generate_keys(number)
    number = number.to_s.split("")
    @keys.each do |letter, num|
      @keys[letter] = number.slice(0..1).join
      number.shift
    end
  end

end
