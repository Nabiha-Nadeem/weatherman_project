module Date_conversion
  def date_converter(date)
    return date.split("-")[2].to_i
  end

  def month_converter(month, i)
    (i == 1) ? month = Date::ABBR_MONTHNAMES[month.to_i] : month = Date::MONTHNAMES[month.to_i]
    return month
  end

  def find_date(array, dates)
    val = yield
    index_no = array.index(val)
    date_raw = dates[index_no]
    date = date_converter(date_raw)
    month = month_converter(date_raw.split("-")[1], 0)
    return val, "#{month} #{date}"
  end
end