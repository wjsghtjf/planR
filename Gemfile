

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'bundler', '~>1.16.3'

#ec2 secret_key 관리
gem 'figaro'

gem 'devise', git: 'https://github.com/plataformatec/devise.git'
gem 'rolify'

gem 'authority'  # 권한설정

#이미지 업로드하기
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'

#이미지 사이즈 조정
gem "mini_magick"
# minimagick을 사용하기 위해서는 image_magick도 설치
#console에서 sudo yum update -> sudo yum install ImageMagick
 
#Fog는 클라우드에파일의 저장을 쉽게할 수 있도록 도와주는 gem
gem 'fog-aws' 
#bootstrap 설치
gem 'bootstrap-sass'
gem 'simple_form'

#jQuery 설치
gem 'jquery-rails'
#팝업기능
gem 'magnific-popup-rails', '~> 1.1'

#회원가입 관련 정보
#권한 관련
gem 'cancancan'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'


gem 'wysiwyg-rails'
gem 'summernote-rails'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


  
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

#서버 올리기
gem 'therubyracer', platforms: :ruby



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  
  #디버깅..
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  
  
  # Use sqlite3 as the database for Active Record
 gem 'sqlite3'

end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # To Show RAILS DB Website
  gem 'rails_db', '2.0.2'
  
  
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

group :production do
  gem 'pg','~> 0.21'
end




# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

