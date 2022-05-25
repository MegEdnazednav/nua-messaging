class RepliesController < ApplicationController
  include MessageHelper

  def new
    @new_message = Message.new
    @original_message = Message.find(params[:message_id])
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      redirect_to messages_path
    else
      redirect_to new_message_reply_path(create_params[:outbox_id], @message)
    end
  end

  private
  def create_params
    params.require(:message).permit(:body, :outbox_id, :inbox_id)
  end

end
