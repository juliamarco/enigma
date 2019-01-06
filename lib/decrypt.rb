require './enigma.rb'
require 'date'


handle = File.open(ARGV[0], "r")
encrypted = handle.read
handle.close

enigma = Enigma.new

key = ARGV[2]
date = ARGV[3]
decrypted = enigma.decrypt(encrypted, key, date)

file_name = ARGV[1]
writer = File.open(file_name, "w")

writer.write(decrypted[:decryption])

puts "Created '#{file_name}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"

writer.close
