class ChurchMailer < ActionMailer::Base
  default from: "admin@easygivekiosk.com"
  
  
  def invite_email(email,subject,content)
 # logger.info "##########################################################################"
#  logger.info "#{email} #{subject} #{content}"
  
  email =  email.split(',')
  
  mail(to: email,
         body: content,
         content_type: "text/html",
         subject: subject)
  end
  
end
