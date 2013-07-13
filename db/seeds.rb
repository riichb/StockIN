# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# stock data
stock_file = File.open("#{Rails.root}/db/stock.txt")
stock_file.read.each_line do |line|
  name, quantity = line.chomp.split("|")

  Stock.find_or_create_by_name!(:name => name, :quantity => quantity)
end
puts "Successfully seeded inventory."