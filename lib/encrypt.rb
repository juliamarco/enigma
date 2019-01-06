require './enigma.rb'
require 'date'

handle = File.open(ARGV[0], "r")
message = handle.read.chop
handle.close

enigma = Enigma.new
encrypted = enigma.encrypt(message)

file_name = ARGV[1]
writer = File.open(file_name, "w")
writer.write(encrypted)

p "File: #{file_name}, key: #{encrypted[:key]}, date: #{encrypted[:date]}"

writer.close
