require 'rubygems'
require 'rmagick'

class RenamePhotos
  attr_accessor :base_folder, :destination_folder
  def initialize
    @base_folder = "/Users/brian/Desktop/wedding_pics"
    @destination_folder = "/Users/brian/Desktop/wedding_pics/all"
  end
  
  def write_data(day, time, image)
    postfix = 0
    while (File.exists?("#{@destination_folder}/#{day[0]+day[1]+day[2]}-#{time[0]+time[1]+time[2]}-#{postfix}.jpg"))
      postfix = postfix + 1
    end
    file_name = "#{@destination_folder}/#{day[0]+day[1]+day[2]}-#{time[0]+time[1]+time[2]}-#{postfix}.jpg"
    image.write(file_name)
  end
  
  def read_data(image)
    datetime = image.get_exif_by_entry("DateTimeOriginal")[0][1].split(" ")
    write_data(datetime[0].split(":"), datetime[1].split(":"), image)
  end
  
  def go
    Dir["#{@base_folder}/*"].each do |folder|
      Dir["#{folder}/*"].each do |image|
        read_data(Magick::Image.read("#{image}").first)
      end
    end
  end

end

RenamePhotos.new.go