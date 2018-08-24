class ImageUploader < CarrierWave::Uploader::Base
  # 이미지를 조정할 수 있는 툴 설정
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # 이미지를 저장할 장소의 종류를 설정
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  #이미지가 저장되는 위치
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 요청한 이미지가 없을 때 대체해서 사용하는 default 이미지 설정
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # 이미지를 저장할 사이즈 조정
  # Process files as they are uploaded:
  # process scale: [400, 600]
  # #
  # def scale(width, height)
  #   # do somethingc
  #   image = MiniMagick::Image.open(self.file.file)
  # end

  # 여러가지 이미지의 버전 설정
  # Create different versions of your uploaded files:
  # process :resize_to_limit => [600, 768]



  #version은 s3 Store에 파일을 저장시킬 때 원본 파일 이외에도 다른 버전의 파일을 추가 할 수 있다.
  # 이를 사용하는 이유는 원본 파일을 저장하고 원본파일을 가져오면 이미지 로딩이 오래걸리기 때문에
  # resize로 축소된 이미지를 가져오며 thumb같은 경우 썸네일 이미지라고 생각하면 된다.


  #resize_to_fit 같은 경우 600 혹은 1000중에 하나의 값에 맞추고 나머지는 비율에 맞게 조정한다.
  #resize_to_fill 의 경우는 비율을 무시하고 특정 크기로 조절한다.
     
  process resize_to_fit: [600, 1000]

  
  version :thumb do
    # 가로가 긴 경우는 240*180으로 세로가 긴경우는 240*320으로 조절한다.
      process :resize_to_fill => [240, 180]  ,:if => :horizontal?
      process :resize_to_fill => [240, 320]  ,:if => :vertical?
  end

  # 아래의 소스는 가로 세로 비율 중어디가 긴지 확인하다.
  def horizontal?(new_file)
    image = MiniMagick::Image.open(self.file.file)
    true if image[:height] < image[:width]
  end
  
  def vertical?(new_file)
    image = MiniMagick::Image.open(self.file.file)
    true if image[:height] > image[:width]
  end
  
  
  # 저장될 파일들의 확장자 설정
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # 저장되는 파일의 이름 설정
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
