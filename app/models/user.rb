class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/

  scope :confirmed, -> { where.not(confirmed_at: nil)}

  def self.authenticate(email, password)
    user = confirmed.find_by(email: email)
    if user.present?
      user.authenticate(password)
    end 
  end

  validates_presence_of :email, :full_name, :location
  validates_length_of :bio, minimum: 10, allow_blank: false#tamanho de 30 caract e não pode ficar em branco
  validates_format_of :email, with: EMAIL_REGEXP

  has_secure_password

#calback p/ gerar o token
  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64 #numeros aleatorios
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end
end
