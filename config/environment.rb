# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FlashingDeal::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
	html_tag
end

if Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => 587,
    :authentication => :plain,
    :user_name => ENV["app2613924@heroku.com"],
    :password => ENV["c888x1dp"],
    :domain => "flashingdeals.com",
    :enable_starttls_auto => true
  }
  ActionMailer::Base.delivery_method = :smtp
else
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "http://www.flashingdeals.com",
    :user_name            => "hello@flashingdeals.com",
    :password             => "ereiniondebitc",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
end

class Hash
  def paginate(all = nil, options = {})
    options[:page] = (options[:page].to_i == 0) ? 1 : options[:page].to_i
    options[:per_page] = (options[:per_page].to_i == 0) ? 30 : options[:per_page].to_i    
    pagination_array = WillPaginate::Collection.new(options[:page], options[:per_page], self.size)
    start_index = pagination_array.offset
    end_index = start_index + (options[:per_page] - 1)
    array_to_concat = self[start_index..end_index]
    array_to_concat.nil? ? [] : pagination_array.concat(array_to_concat)
  end
end