require 'csv'

module Parse_Data
  def get_data(year, month, directory_name, fields)
    # fields is an array of column names that are to be retrieved
    if month == nil
      Dir.chdir("/home/dev/RubymineProjects/weatherman/weather/#{directory_name}")
      files = Dir.glob("*#{year}*.txt")
    else
      month_abbr = month_converter(month, 1)
      Dir.chdir("/home/dev/RubymineProjects/weatherman/weather/#{directory_name}")
      files = Dir.glob("*#{year}_#{month_abbr}.txt")
    end
    data = parse_data(files, fields)
    return *data
  end

  def parse_data(files, fields)
    my_arr = []
    fields.each_with_index {|field, i| my_arr[i] = []}

    files.each do |file_name|
      data = CSV.parse(File.read(file_name), headers: true, skip_blanks:true)
      fields.each_with_index do |field, i|
        (field == "GST") ? my_arr[i] << data.by_col[0].reject{|item| item.start_with?('<')} : my_arr[i] << data[field].reject(&:nil?)
      end
    end

    if fields.include?("GST")
      my_arr.each_with_index {|field, i| (i != 0) ? my_arr[i] = my_arr[i].flatten.map! {|e| e.to_i} : my_arr[i] = my_arr[i].flatten}
    else
      my_arr.each_with_index {|field, i| my_arr[i] = my_arr[i].flatten.map! {|e| e.to_i}}
    end

    return my_arr
  end
end