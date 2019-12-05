class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    if current_user
      @messages = Message.joins(:user1).joins('INNER JOIN "users" as "users2" ON "users2"."id" = "messages"."receiver_id"').select('messages.*, users.username AS sender_username, users2.username AS receiver_username').where('sender_id = ? OR receiver_id = ?', session[:user_id], session[:user_id])
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @sender = User.find(@message.sender_id)
    @receiver = User.find(@message.receiver_id)
  end

  # GET /messages/new
  def new
    if current_user
      @message = Message.new
      @users = User.where('id != ?', current_user.id)
    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    if current_user == nil or current_user.id != @message.sender_id
      respond_to do |format|
          format.html { redirect_to posts_url, notice: 'You do not have the proper permissions to delete that post.' }
          format.json { render json: {'error' => 'You do not have the proper permissions to delete that post.'} }
      end
      return
    end
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      p = params.require(:message).permit(:receiver_id, :body)
      if current_user
        p[:sender_id] = current_user.id
      end
      return p
    end
end
