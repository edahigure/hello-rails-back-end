class Api::V1::MessagesController < ApplicationController
  def index
    messages = Message.find(Message.pluck(:id).sample)

    if messages
      render json: { status: 'SUCCESS', message: 'Fetched all the messages successfully', data: messages }, status: :ok
    else
      render json: messages.errors, status: :bad_request
    end
  end

  def create
    message = Message.new(message_params)
  
    if message.save
      render json: {status: "SUCCESS", message: "Message was created successfully!", data: message}, status: :created
    else
      render json: message.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:text)
  end
end