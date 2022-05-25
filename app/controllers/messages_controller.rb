class MessagesController < ApplicationController
  def index
    if params[:box] == 'outbox'
      @messages = @current_user.outbox.messages.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    else
      @messages = @current_user.inbox.messages.paginate(page: params[:page], per_page: 10).order(created_at: :desc)
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.update(read: true) if @current_user.id == @message.inbox.user_id
  end

  def new
    @message = Message.new
    @users = User.where.not(id: @current_user.id)
  end

  def create
    @message = Message.new(create_params)
    if @message.save
      redirect_to messages_path
    else
      redirect_to new_message_path
    end
  end

  private
  def create_params
    params.require(:message).permit(:body, :outbox_id, :inbox_id)
  end
end
