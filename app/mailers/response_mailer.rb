class ResponseMailer < ActionMailer::Base
  default :from => "from@example.com"

  def email_response(name, email, result, uuid)
    @email = email
    @name = name
    @result = result 
    @uuid = uuid
        mail(:to => email, :subject => "AB-Tech: Online Readiness Results")
  end
end
