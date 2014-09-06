class RenamePhotos
  require 'mini_magick'
  require 'date'
  include MiniMagick

  attr_accessor :base_folder, :destination_folder, :counter

  def initialize(base, destination)
    @base_folder = base
    @destination_folder = destination
    puts "Base #{base} Destination #{destination}"
    @counter = 1
  end

  def write_data(date, image, ext)
    postfix = 0
    # 20101223-123415-0
    # do some fancy strftime stuff instead of this fantastic array index formatting
    while (File.exists?("#{@destination_folder}/#{date.strftime("%Y%m%d-%H%M%S")}-#{postfix}.#{ext}"))
      postfix = postfix + 1
    end
    file_name = "#{@destination_folder}/#{date.strftime("%Y%m%d-%H%M%S")}-#{postfix}.#{ext}"
    image.write(file_name)
    puts "Writing file number #{@counter}"
    @counter = @counter + 1
  end

  def read_data(image, ext)
    created_at = image['EXIF:DateTimeOriginal']
    d = if ext == 'JPG'
      fmt = "%Y:%m:%d %H:%M:%S"
      DateTime.strptime created_at, fmt
    elsif ext == 'NEF'
      DateTime.parse created_at
    end
    puts "d #{d}"
    write_data(d, image, ext)
  end

  def go
    puts "before Job: " + Dir["#{@destination_folder}/*"].count.to_s + " files"
    Dir["#{@base_folder}/**/*"].each do |image|
      unless File.directory?(image)
        i = Image.open("#{image}")
        ext = image.split("/").last.split(".").last
        puts "### #{i.path} ext: #{ext} ###"
        read_data(i, ext)
        i.destroy!
      end
    end
    puts "After Job: "+ Dir["#{@destination_folder}/*"].count.to_s + " files"
  end

end

RenamePhotos.new(ARGV[0], ARGV[1]).go
