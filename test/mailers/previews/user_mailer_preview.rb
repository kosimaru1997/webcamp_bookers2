# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_mail
  def welcome_mail
    user = User.find(2)
    UserMailer.welcome_mail(user)
  end

end
