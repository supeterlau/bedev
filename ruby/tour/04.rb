#!/usr/bin/ruby -w

class Customer
  @@number_of_customers = 0

  def initialize(id, name, addr)
    @cust_id = id
    @cust_name = name
    @cust_addr = addr
  end

  def whoami()
    puts "#{@cust_id} - #{@cust_name} - #{@cust_addr}"
  end
end

# cust1 = Customer.new
# cust2 = Customer.new

cust1 = Customer.new("1", "Jack", "Alibaba")
cust2 = Customer.new("2", "Pony", "Tencent")
puts cust1,cust2
cust1.whoami
