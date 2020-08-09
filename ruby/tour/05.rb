#!/usr/bin/ruby -w

$which_year = 2020

class Day
  def print_year
    puts "Global variable in Day is #$which_year"
  end
end

class Week
  def print_year
    puts "Global variable in Week is #$which_year"
  end
end

day = Day.new
day.print_year

week = Week.new
week.print_year

class Customer
  @@number_of_customers = 0
  Type = 'customer'

  def initialize(id, name, addr)
    @customer_id = id
    @customer_name = name
    @customer_add = addr
    @@number_of_customers += 1
  end

  def total_number_of_customers()
    # @@number_of_customers += 1
    puts "Total number of customers: type #{Type} #@@number_of_customers"
  end
end

customer1 = Customer.new("1", "Jack", "Alibaba")
customer2 = Customer.new("2", "Pony", "Tencent")
customer1.total_number_of_customers
customer2.total_number_of_customers
customer1.total_number_of_customers

simple = ["fred", 10, 3e20, "last element",]
simple.each do |i|
  puts i
end

colors = {"red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f}
colors.each do |key, value|
  print key, " is ", value, "\n"
end

(10...15).each do |n|
  print n, ' '
end
