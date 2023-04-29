# https://zetcode.com/ruby/socket/

require 'socket'

s = TCPSocket.new 'webcode.me', 80
s.write "GET / HTTP/1.0\r\n\r\n"

res = s.read
puts res

s.close
