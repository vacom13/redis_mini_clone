require 'socket'

s = TCPSocket.new 'localhost', 6380

puts "Connected to the server"

# Send data to the server
message = "PING"
s.puts(message)
puts "Sent: #{message}"

# Optionally, receive a response
response = s.gets
puts "Received: #{response}" if response