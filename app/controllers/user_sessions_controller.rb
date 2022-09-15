class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new(session)
  end

  def create
    @user_session = UserSession.new(session, params[:user_session])#Nova instancia da classe Session

    if @user_session.authenticate!#metodo sendo chamado p/ gravar na Sessão caso as credenciais estejam corretas

      redirect_to root_path, notice: I18n.t('flash.notice.signed_in')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end
end
