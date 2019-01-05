class Enigma
  attr_reader :character_set,
              :keys

  def initialize
    @character_set = ("a".."z").to_a << " "
    @keys = []
  end

end
