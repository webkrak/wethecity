# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*)
    ActionController::Base.helpers.asset_path('users/' + [version_name, 'default.png'].compact.join('_'))
  end

  process resize_to_fit: [400, 400]

  # def scale(width, height)
  #   # do something
  # end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def content_type_whitelist
    %r{image\/}
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
