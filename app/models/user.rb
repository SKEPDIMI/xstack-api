require 'devise_token_auth'

class User < ApplicationRecord
  mount_uploader :image, UserImageUploader
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  # User Img Validation
  validates_integrity_of  :image
  validates_processing_of :image
 
  before_validation :sanitize_field

  private
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end
    def sanitize_field
      self.name = sanitize self.name unless self.name.nil?
      self.nickname = sanitize self.nickname unless self.nickname.nil?
      self.bio = sanitize self.bio unless self.bio.nil?
      self.description = sanitize self.description unless self.description.nil?
      self.url = sanitize self.url unless self.url.nil?
    end
    def sanitize(n)
      return Sanitize.fragment(n)
    end
end
