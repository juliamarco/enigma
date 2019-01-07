require './lib/enigma.rb'
require 'date'

handle = File.open(ARGV[0], "r")
encrypted = handle.read
handle.close

enigma = Enigma.new

date = ARGV[2]

cracked = enigma.crack(encrypted, date)

cracked_file = ARGV[1]
writer = File.open(cracked_file, "w")

writer.write(cracked[:decryption])

puts "Created '#{cracked_file}' with the key #{cracked[:key]} and date #{cracked[:date]}"

writer.close
