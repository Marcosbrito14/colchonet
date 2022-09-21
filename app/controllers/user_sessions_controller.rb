class UserSessionsController < ApplicationController
#3 passo - criação do controller UserSessions p/ o formulario de login
#variaveis de instancia pra usarmos nos template
  def new
    @user_session = UserSession.new(session)#Objeto p/ uma nova sessão
  end

#6 passo - Parametros que vem do formulario
  def create
    @user_session = UserSession.new(session, params[:user_session])#Criação de uma instancia da classe Session

    if @user_session.authenticate!#8a - passo metodo p/ autenticar se o usuario esta na sessão
#OBS - A etapa final virá do retorno do metodo se for V ou F

      redirect_to root_path, notice: I18n.t('flash.notice.signed_in')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end
end
