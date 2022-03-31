require 'colorize'

module Print_data
  def print_temperature(values, dates)
    puts "Highest: #{values[0]}C on #{dates[0]}"
    puts "Lowest: #{values[1]}C on #{dates[1]}"
    puts "Humidity: #{values[2]}% on #{dates[2]}"
    puts " "
  end

  def print_avg_temperature(values)
    puts "Highest Average: #{values[0]}C"
    puts "Lowest Average: #{values[1]}C"
    puts "Humidity Average: #{values[2]}%"
    puts " "
  end

  def print_two_barchart(arr1, arr2, arr3)
    arr1.zip(arr2, arr3).each do |date, max, min|
      print "#{'%02d' % date_converter(date)} ".italic
      if max
        max.times do
          print "+".red.italic
        end
        print " #{'%02d' % max}C \n".italic
      else
        print "00 \n".italic
      end
      if min
        print "#{'%02d' % date_converter(date)} ".italic
        min.times do
          print "+".blue.italic
        end
        print " #{'%02d' % min}C \n".italic
      else
        print "#{'%02d' % date_converter(date)} ".italic
        print "00 \n".italic
      end
    end
    print "\n"
  end

  def print_one_barchart(arr1, arr2, arr3)
    arr1.zip(arr2, arr3).each do |date, max, min|
      print "#{'%02d' % date_converter(date)} ".italic
      if max
        max.times do
          print "+".red.italic
        end
      end
      if min
        min.times do
          print "+".blue.italic
        end
      end
      if max
        print " #{'%02d' % max}C -".italic
      else
        print "00 -".italic
      end
      if min
        print " #{'%02d' % min}C \n".italic
      else
        print " 00 \n".italic
      end
    end
  end
end