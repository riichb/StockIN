class Stock < ActiveRecord::Base
  attr_accessible :name, :quantity

  def self.weekly_report
  	UserMailer.weekly_report_email().deliver
  end
end
