class ResponseMailer < ActionMailer::Base
  default :from => "donotreply@abtech.edu"

  def email_response(name, email, suggestion_for_email, result_for_email, uuid)
    @email = email
    @name = name
    @result_for_email = result_for_email
    @suggestion_for_email = suggestion_for_email
    @uuid = uuid
        mail(:to => email, :subject => "AB-Tech: Online Readiness Results")
  end
end
