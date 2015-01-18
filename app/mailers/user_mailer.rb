class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_email(products,users)
    @products = products


    mail(to: 'roshanshrestha@lftechnology.com', subject: 'Product created by #{users.email})')

  end
end
