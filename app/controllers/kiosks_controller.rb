class KiosksController < ApplicationController
   def show
      @kiosk = Kiosk.find(params[:id])
      @user = User.find(@kiosk.user_id)

   end

def new
  @kiosk = Project.new
end

  def update
    begin
     desc = "Donation to  " + params[:id]
     token = params[:stripeToken]
     amount = params[:kiosk][:donations_attributes]["0"][:amount].to_f * 100
     stripe_uid = params[:kiosk][:stripe_uid]

     amount = amount.to_i
     email = params[:kiosk][:donations_attributes]["0"][:email]

      stripe_params = {
       :amount => amount,
      :currency => "usd",
      :source => token,
      :description => desc,
      :application_fee => 30,


     }

     #send out receipt  as well
     if !email.blank?
        stripe_params[:receipt_email] = email

     end
     Stripe.api_key = Rails.application.secrets.secret_key
       # => email,
     charge = Stripe::Charge.create(stripe_params ,{:stripe_account => stripe_uid})
   rescue Stripe::CardError => e
   else
    @kiosk = Kiosk.friendly.find(params[:id])
    if @obj = @kiosk.update(donation_params)
        if !email.blank?
            KioskMailer.receipt_email(charge).deliver
        end
        render 'success'
    end
    end
  end


  def invite
   @kiosk = Kiosk.find(params[:id])

   if params.include?(:kiosk)
      KioskMailer.invite_email(params[:kiosk][:email],params[:kiosk][:subject], params[:kiosk][:mail_content]).deliver
      #mail(to: params[:kiosk][:email], subject: params[:kiosk][:subject], content: params[:kiosk][:mail_content])
      render 'invited'
   end
  end


  private

    def donation_params
      params.require(:kiosk).permit(donations_attributes:  [:title,:name, :email, :amount, :stripeToken, :stripe_uid] )
    end
end
