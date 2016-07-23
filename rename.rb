#!/usr/bin/env ruby
require 'exifr'

files = Dir[File.join(ARGV[0], "/**/*")].select { |name| name.downcase =~ /\.(jpeg|jpg|JPG)/ }

rejected_files = []

files.each do |filename|
  date_time = EXIFR::JPEG.new(filename).date_time

  if date_time
    formatted_date = date_time.to_datetime.iso8601
    pieces = filename.split("/")
    new_filename = (pieces[0...-1] << "#{formatted_date}.jpg").join('/')
     `mv "#{filename}" "#{new_filename}"`
  else
    rejected_files << filename
  end
end

if rejected_files.size == 0
  puts "Cool! all renamed."
else
  puts "Sorry, we could not rename these files"
  puts rejected_files.inspect
end
