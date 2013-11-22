class RenamePhotos
  require 'mini_magick'
  include MiniMagick

  attr_accessor :base_folder, :destination_folder, :counter

  def initialize
    @base_folder = "/Users/brian/Desktop/pic"
    @destination_folder = "/Users/brian/Desktop/final"
    @counter = 1
  end

  def write_data(day, time, image)
    postfix = 0
    # 20101223-123415-0
    # do some fancy strftime stuff instead of this fantastic array index formatting
    while (File.exists?("#{@destination_folder}/#{day[0]+day[1]+day[2]}-#{time[0]+time[1]+time[2]}-#{postfix}.jpg"))
      postfix = postfix + 1
    end
    file_name = "#{@destination_folder}/#{day[0]+day[1]+day[2]}-#{time[0]+time[1]+time[2]}-#{postfix}.jpg"
    image.write(file_name)
    puts "Writing file number #{@counter}"
    @counter = @counter + 1
  end

  def read_data(image)
    d = Date.strptime image['EXIF:DateTimeOriginal'], "%Y:%m:%d %H:%M:%S"
    write_data(d, image)
  end

  def go
    puts "before Job: " + Dir["#{@destination_folder}/*"].count.to_s + " files"
    Dir["#{@base_folder}/**/*"].each do |image|
      i = Image.open("#{image}")
      puts i.path
      read_data(i)
      i.destroy!
    end
    puts "After Job: "+ Dir["#{@destination_folder}/*"].count.to_s + " files"
  end

end

RenamePhotos.new.go
