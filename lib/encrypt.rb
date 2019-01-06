require './enigma.rb'
require 'date'

handle = File.open(ARGV[0], "r")
message = handle.read.chop
handle.close

enigma = Enigma.new
encrypted = enigma.encrypt(message)

file_name = ARGV[1]
writer = File.open(file_name, "w")

writer.write(encrypted[:encryption])

p "Created '#{file_name}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"

writer.close
