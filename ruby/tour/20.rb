#!/usr/bin/ruby -w

fname = "./unexistant_file"
begin
  file = open(fname)
  if file
    puts "Open file successfully #{fname}"
  end
rescue
  puts "failed open file #{fname}"
  fname = "./existant_file"
  retry
end

begin
  puts "Before raise"
  raise "Raise some error"
  puts "After raise"
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
  puts "In rescue"
end

def promptAndGet(prompt)
  print prompt
  res = readline.chomp
  puts "read: #{res}"
  throw :quitRequested if res == "!"
  res
end

catch :quitRequested do
  puts "in catch"
  name = promptAndGet("Name:")
  age = promptAndGet("Age:")
  sex = promptAndGet("Sex:")
end

promptAndGet("Name:")

class FileSaveError < StandardError
  attr_reader :reason
  def initialize(reason)
    @reason = reason
  end
end

path = '123456'
File.open(path, 'w') do |file|
  begin
    raise "Write Error"
  rescue
    raise FileSaveError.new($!)
  end
end
