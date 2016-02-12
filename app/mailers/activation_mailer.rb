class ActivationMailer < ActionMailer::Base
  default from: "admin@easygivekiosk.com"


  def activation_email(activation)
  @content = "<br />Organization: "+activation.title+"<br />Name: <b>"+activation.name+"</b><br />Phone: <b>"+activation.phone+"</b><br />Email: "+activation.email+""

  mail(to: "scott@startgroup.org", subject: 'Merchant account activation - Easygivekiosk.com',  body: @content,  content_type: "text/html").deliver
  end

end
