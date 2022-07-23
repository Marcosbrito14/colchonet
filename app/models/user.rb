class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\Z/

  validates_presence_of :email, :full_name, :location, :password#validação de presença
  validates_confirmation_of :password#validação de password utilizando atributo virtual: password_confirmation
  validates_length_of :bio, minimum: 30, allow_blank: false#tamanho de 30 caract e não pode ficar em branco
  validates_uniqueness_of :email#validar um unico email

  validate do
    errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)#validação de email
  end
end
