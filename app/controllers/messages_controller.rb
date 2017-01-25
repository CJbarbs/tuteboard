class MessagesController < ApplicationController
	before_action :find_message, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!


	def index
		if params[:category].blank?
			@messages = Message.all.order("created_at DESC")
		else 
			@category_id = Category.find_by(name: params[:category]).id
			@messages 	 = Message.where(category_id: @category_id).order("Created_at DESC")
		end
	end 

	def show
	end

	def new
		@message = current_user.messages.build
	end

	def create
		@message = current_user.messages.build(message_params)
		if @message.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @message.update(message_params)
			redirect_to message_path
		else
			render 'edit'
		end
	end

	def destroy
		@message.destroy
		redirect_to root_path
	end

	private
		def message_params
			params.require(:message).permit(:title, :description, :category_id )
		end

		def find_message
			@message = Message.find(params[:id])
		end
end
