class KeysGenerator
  attr_reader :keys

  def initialize(number)
    @keys = {A: 0, B: 0, C: 0, D: 0}
  end

  def generate_keys(number)
    if number == 0
      number = random_number
    end
    assign_num_to_letters(number)
  end

  def random_number
    number = rand(99999)
    "%05d" % number.to_s
  end

  def assign_num_to_letters(number)
    number = number.to_s.split("")
    @keys.each do |letter, num|
      @keys[letter] = number.slice(0..1).join
      number.shift
    end
  end

end
