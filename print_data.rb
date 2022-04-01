require 'colorize'

module Print_data
  def print_temperature(max_temp_val, min_temp_val, max_humid_val, date_max_temp, date_min_temp, date_max_humid)
    puts "Highest: #{max_temp_val}C on #{date_max_temp}"
    puts "Lowest: #{min_temp_val}C on #{date_min_temp}"
    puts "Humidity: #{max_humid_val}% on #{date_max_humid}"
    puts " "
  end

  def print_avg_temperature(max_temp_val, min_temp_val, max_humid_val)
    puts "Highest Average: #{max_temp_val}C"
    puts "Lowest Average: #{min_temp_val}C"
    puts "Humidity Average: #{max_humid_val}%"
    puts " "
  end

  def print_two_barchart(dates, max_temp, min_temp)
    dates.zip(max_temp, min_temp).each do |date, max, min|
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

  def print_one_barchart(dates, max_temp, min_temp)
    dates.zip(max_temp, min_temp).each do |date, max, min|
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
