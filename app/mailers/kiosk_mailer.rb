class KioskMailer < ActionMailer::Base
  default from: "admin@easygivekiosk.com"


  def receipt_email(charge)
    @charge = charge
    mail(to: charge["email"], subject: 'Donation receipt - Easygivekiosk.com')
  end

  def owner_email(charge)
    @charge = charge
    mail(to: charge["email"], subject: 'Donation Received - Easygivekiosk.com')
  end
end
