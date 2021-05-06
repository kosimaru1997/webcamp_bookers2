class DailyMailer < ApplicationMailer
  
  def daily_notification
      default to: -> { User.pluck(:email) }
      mail(subject: "Daily Report of Your Record")
  end

end
