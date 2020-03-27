class MessagesController < ApplicationController
  before_action :require_user

  def create 
    @message=Message.new(message_params)
    @message.user = current_user
    if @message.save 
      
      redirect_to chat_path
    else
      flash[:danger]="somethint wrong !"
      redirect_back fallback_location: 'chatrooms/show'
    end
  end  


  def message_params
    params.require(:message).permit(:content)
  end
  

end