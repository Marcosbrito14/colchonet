class UserSession
#1 passo 
  include ActiveModel::Model #modulo - componente rails

  #permite validações como o activerecord
  attr_accessor :email, :password
  validates_presence_of :email, :password
##################################################

  #inicialização de objetos com hash
  def initialize(session, attributes={})#metodo contrutor p/ aceitar os parametros do formulario e a sessão que vem do controller
    @session = session
    @email = attributes[:email]
    @password = attributes[:password]
  end

  #verifica os dados entrados pelo usuario(email, password)
  def authenticate!
    user = User.authenticate(@email, @password)

    #Se estiverem corretos seram guardados na sessão
    if user.present?
      store(user)
    else
      errors.add(:base, :invalid_login)
      false
    end
  end

  #metodo store é o resposavel em gravar o id do usuario na sessão
  def store(user)
    @session[:user_id] = user.id
  end
end
