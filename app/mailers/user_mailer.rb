class UserMailer < ActionMailer::Base
  default from: "listockin@gmail.com"
  default to: "janicejl@usc.edu"
  
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def low_stock_email(stock) 
  	@stock = stock
  	mail(subject: @stock.name + ' low in stock.')
  end
end
