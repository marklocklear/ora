class ResponseMailer < ActionMailer::Base
  default :from => "from@example.com"

  def email_response(name, email, suggestion_for_email, result_for_email, uuid)
    @email = email
    @name = name
    @result_for_email = result_for_email
    @suggestion_for_email = suggestion_for_email
    @uuid = uuid
        mail(:to => email, :subject => "AB-Tech: Online Readiness Results")
  end
end
