class MessagesController < ApplicationController
	before_filter :authenticate

	def index
		@title = "Messages"
		@user = current_user
		users = current_user.received_messages.map{ |m| m.user_id }.uniq
		@msgs = []
		users.each do |x|
			@msgs.push(User.find(x).send_messages.where("recipient_id = ?", current_user.id).order("created_at DESC").first)
		end
		@messages = @msgs.sort_by { |message| message.created_at }.reverse
		respond_to do |format|
			format.mobile { render :layout => 'application_in' }
		end
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
		@title = "#{@sender.name} - Messages"
		@total_messages = current_user.received_messages
		unless @message.user_id == current_user.id
			unless @received_messages.where("read = ?", false) == 0
				@received_messages.where("read = ?", false).each do |message|
					message.update_attribute(:read, true)
				end
			end
		end
		respond_to do |format|
			format.html {
				if @messages_size > 10
					@messages = messages[0..9]
					@messages_more = messages[10..@messages_size]
				else
					@messages = messages
				end
			}
			format.mobile { 
				if messages.size > 20
					@messages = messages[0..19]
				else
					@messages = messages
				end
				render :layout => 'application_in'
			}
		end
	rescue ActiveRecord::RecordNotFound
		@title = "Messages"
		redirect_to messages_path
	end
	
	def create
		if User.find_by_name("#{params[:friend_name]}").nil?
			flash[:error] = "Your message was unable to send."
			redirect_to my_account_path
		elsif current_user.id == User.find_by_name("#{params[:friend_name]}").id
			@message = current_user.send_messages.create!(:recipient_id => User.find_by_name("#{params[:friend_name]}").id, :content => params[:message][:content], :read => true)
			if @message.save
				flash[:success] = "You sent yourself a message!"
				redirect_to @message
			end
		else
			params[:message][:recipient_id] = User.find_by_name("#{params[:friend_name]}").id
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
				request.format = :mobilejs if request.format == :mobile
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
					format.mobilejs {
						@sender = User.find(message.recipient_id)
						@message = message
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
		user = current_user
		sender = User.find(message.user_id)
		received_messages = Message.where("user_id = #{sender.id} AND recipient_id = #{user.id} AND read = ? AND created_at < ?", false, message.created_at)
		received_messages.each do |message|
			message.update_attribute(:read, true)
		end
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