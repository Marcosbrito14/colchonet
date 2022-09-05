class NewRoom < ActionMailer::Base
  default from: 'no-reply@colcho.net'

  def confirm_room(room, user)
    @room = room
    @user = user
    #byebug
    #@url = room_url(room)

    mail({
      to: user.email,
      subject: 'bla'
      })
  end
end
