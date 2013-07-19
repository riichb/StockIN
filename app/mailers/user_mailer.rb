class UserMailer < ActionMailer::Base
  default from: "listock@gmail.com"
  default to: "tsaelinh@linkedin.com"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def low_stock_email(stock) 
  	@stock = stock
  	mail(subject: @stock.name + 'low in stock.')
  end

  def weekly_report_email()
  	@stocks = Stock.all
  	mail(subject: 'Weekly Report' )
  end
end
