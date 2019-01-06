require './enigma.rb'
require 'date'

handle = File.open(ARGV[0], "r")
message = handle.read.chop
enigma = Enigma.new
encrypted_message = enigma.encrypt(message)
# require 'pry'; binding.pry
