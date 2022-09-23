class RoomsController < ApplicationController
                          #apenas/só
  before_action :set_room, only: [ :show, :edit, :update, :destroy ]
  before_action :require_authentication,
    only: [:new, :edit, :create, :update, :destroy]

  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  #Exibir as solicitações do room solicitado
  def show
  end

  # GET /rooms/new
  # Exibir formulario de um novo room
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        NewRoom.confirm_room(@room, User.find_by(email: 'lucas@gmail.com')).deliver

        format.html { redirect_to room_url(@room), notice: t('flash.notice.room_created') }
        #format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: t('flash.notice.room_updated') }
        #format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use retornos de chamada para compartilhar configurações ou restrições comuns entre as ações.
    def set_room
      @room = Room.find(params[:id])
    end

    # Permitir apenas uma lista de parâmetros confiáveis.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
