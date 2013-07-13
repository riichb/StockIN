ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:domain => "gmail.com",
	:user_name => "listockin", 
	:password => "hackday2013",
	:authentication => "plain", 
	:enable_starttls_auto => true
}

if Rails.env.production?
	ActionMailer::Base.default_url_options[:host] = "listock.herokuapp.com" 
else 
	ActionMailer::Base.default_url_options[:host] = "localhost:3000" 
end