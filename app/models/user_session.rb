class UserSession
#1 passo - classe UserSession p/ criar modelos de sessão
  include ActiveModel::Model #permite validações como o activerecord

  attr_accessor :email, :password
  validates_presence_of :email, :password

#7 passso - metodo contrutor p/ aceitar os parametros do formulario e a sessão que vem do controller
  def initialize(session, attributes={})
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

#8b passo - metodo para autenticar o usuario
#O metodo esta utilizando a classe User e o metodo authenticate
  def authenticate!
    user = User.authenticate(@email, @password)#9a passo - metodo aplicado no modelo User pra retonar objeto V ou F

    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  #10b passo - metodo store(armazenar) é o resposavel em gravar o id do usuario na sessão
  def store(user)
    @session[:user_id] = user.id
  end
end













def teteste
  false
end
