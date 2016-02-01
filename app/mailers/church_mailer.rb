class ChurchMailer < ActionMailer::Base
  default from: "admin@easygivekiosk.com"


  def invite_email(email,subject,content)
 # logger.info "##########################################################################"
#  logger.info "#{email} #{subject} #{content}"

  email =  email.split(',')

  mail(bcc: email,
         body: content,
         content_type: "text/html",
         subject: subject)
  end


  def receipt_email(charge)
  #  print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
  #  print charge.inspect
  #  print charge.receipt_email
  @charge = charge
  mail(to: charge.receipt_email, subject: 'Donation receipt - Easygivekiosk.com')
  end

end
