require 'csv'
require 'colorize'
require_relative 'date_conversion'
require_relative 'parse_data'
require_relative 'print_data'

class Weatherman

  @@fields = ["GST", "Max TemperatureC" , "Min TemperatureC", "Max Humidity"]

  def initialize(year, directory_name, task_no, month = nil)
    self.extend Parse_Data
    self.extend Date_conversion
    self.extend Print_data
    @year = year
    @month = month
    @directory_name = directory_name
    @task_no = task_no
    @dates, @max_temp, @min_temp, @humidity = get_data(@year, @month, @directory_name, @@fields)
  end


  def temperature
    max_temp_val, date_max_temp = find_date(@max_temp, @dates) {@max_temp.max}
    min_temp_val, date_min_temp = find_date(@min_temp, @dates) {@min_temp.min}
    max_humid_val, date_max_humid = find_date(@humidity, @dates) {@humidity.max}

    values = [max_temp_val, min_temp_val, max_humid_val]
    dates = [date_max_temp, date_min_temp, date_max_humid]

    print_temperature(values, dates)
  end

  def avg_temperature

    max_temp_val = @max_temp.sum / @max_temp.size.to_f
    min_temp_val = @min_temp.sum / @min_temp.size.to_f
    max_humid_val = @humidity.sum / @humidity.size.to_f

    values = [max_temp_val, min_temp_val, max_humid_val]
    print_avg_temperature(values)
  end

  def bar_chart_temperature
    puts "#{month_converter(@month, 0)} #{@year}"
    if @task_no == 3
      print_two_barchart(@dates, @max_temp, @min_temp)
    else
      print_one_barchart(@dates, @max_temp, @min_temp)
    end
  end
end



options = %w[-e -a -c -d]
directories = %w[Murree_weather lahore_weather Dubai_weather]
length_year_string = [4, 6, 7]
if (options).include? ARGV[0] and (length_year_string).include? ARGV[1].length and (directories).include? ARGV[2]
  if ARGV[0] == options[0]
    object = Weatherman.new(ARGV[1].to_i, ARGV[2], 1)
    object.temperature
  else
    if ARGV[0] == options[1]
      task = 2
      function = lambda {|object| object.avg_temperature}
    else
      function = lambda {|object| object.bar_chart_temperature}
      (task = 3) if (ARGV[0] == options[2])
      (task = 4) if (ARGV[0] == options[3])
    end
    object = Weatherman.new(ARGV[1].split('/')[0].to_i, ARGV[2], task, ARGV[1].split('/')[1].to_i)
    function.call(object)
  end
else
  raise 'Invalid arguments passed.'
end

