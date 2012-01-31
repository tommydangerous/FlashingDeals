class MessagesController < ApplicationController
	before_filter :authenticate

	def index
		@title = "Messages"
		@user = current_user
		@messages = current_user.received_messages.order("created_at DESC").paginate(:page => params[:page], :per_page => 40)
	end
	
	def show
		@message = Message.find(params[:id])
		@user = current_user
		@sender = User.find(@message.user_id)
		if @user == @sender
			@sender = User.find(@message.recipient_id)
			@send_messages = Message.where("user_id = #{@user.id} AND recipient_id = #{@sender.id}")
			@received_messages = Message.where("user_id = #{@sender.id} AND recipient_id = #{@user.id}")
		else
			@send_messages = Message.where("user_id = #{@user.id} AND recipient_id = #{@sender.id}")
			@received_messages = Message.where("user_id = #{@sender.id} AND recipient_id = #{@user.id}")
		end
		messages = (@send_messages + @received_messages).sort_by { |message| message.created_at }.reverse
		@messages_size = messages.size
		if @messages_size > 10
			@messages = messages[0..9]
			@messages_more = messages[10..@messages_size]
		else
			@messages = messages
		end
		@title = "#{@sender.name} - Messages"
		@total_messages = current_user.received_messages
		unless @message.user_id == current_user.id
			unless @message.read == true
				@received_messages.where("read = ?", false).each do |message|
					message.update_attribute(:read, true)
				end
			end
		end
	rescue ActiveRecord::RecordNotFound
		@title = "Messages"
		redirect_to messages_path
	end
	
	def create
		if User.find_by_id(params[:message][:recipient_id]).nil?
			flash[:error] = "Message cannot be sent to a nonexistent user."
			redirect_to my_account_path
		elsif current_user.id == User.find_by_id(params[:message][:recipient_id]).id
			@message = current_user.send_messages.create!(:recipient_id => params[:message][:recipient_id], :content => params[:message][:content], :read => true)
			if @message.save
				flash[:success] = "You sent yourself a message!"
				redirect_to @message
			end
		else
			message = current_user.send_messages.create(params[:message])
			user = current_user
			sender = User.find(message.user_id)
			if user == current_user
				sender = User.find(message.recipient_id)
				send_messages = Message.where("user_id = #{user.id} AND recipient_id = #{sender.id}")
				received_messages = Message.where("user_id = #{sender.id} AND recipient_id = #{user.id}")
			else
				send_messages = Message.where("user_id = #{user.id} AND recipient_id = #{sender.id}")
				received_messages = Message.where("user_id = #{sender.id} AND recipient_id = #{user.id}")
			end
			messages = (send_messages + received_messages).sort_by { |message| message.created_at }.reverse
			if message.save
				respond_to do |format|
					format.html {
						flash[:success] = "Message sent."
						redirect_to message
					}
					format.js { 
						@sender = User.find(message.recipient_id)
						@message = message
						@messages = messages
					}
				end
			else
				flash[:error] = "Unable to send message for some reason."
				redirect_to my_account_path
			end
		end
	end
	
	def update
		message = Message.find(params[:id])
		if message.update_attribute(:read, params[:message][:read])
			respond_to do |format|
				format.html { redirect_to messages_path }
				format.js {
					@message = message
				}
			end			
		else
			flash[:error] = "Message update failed."
			redirect_to my_account_path
		end
		
	end
	
	def read_all
		@messages = current_user.received_messages.where("read = ?", false)
		@messages.each do |message|
			message.update_attribute(:read, true)
		end
		redirect_to messages_path
	end
	
	def unread_all
		@messages = current_user.received_messages.where("read = ?", true)
		@messages.each do |message|
			message.update_attribute(:read, false)
		end
		redirect_to messages_path
	end
end