class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/

  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, minimum: 10, allow_blank: false#tamanho de 30 caract e não pode ficar em branco
  validates_format_of :email, with: EMAIL_REGEXP

  has_secure_password

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
  end 
end
