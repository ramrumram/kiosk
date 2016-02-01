class ChurchesController < ApplicationController
   def show
      @church = Church.friendly.find(params[:id])
      @user = User.find(@church.user_id)

   end

def new
  @church = Project.new
end

  def update
    begin
     desc = "Donation to  " + params[:id]
     token = params[:stripeToken]
     amount = params[:church][:donations_attributes]["0"][:amount].to_f * 100
     stripe_uid = params[:church][:stripe_uid]

     amount = amount.to_i
     email = params[:church][:donations_attributes]["0"][:email]

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
    @church = Church.friendly.find(params[:id])
    if @obj = @church.update(donation_params)
        if !email.blank?
            ChurchMailer.receipt_email(charge).deliver
        end
        render 'success'
    end
    end
  end


  def invite
   @church = Church.friendly.find(params[:id])

   if params.include?(:church)
      ChurchMailer.invite_email(params[:church][:email],params[:church][:subject], params[:church][:mail_content]).deliver
      #mail(to: params[:church][:email], subject: params[:church][:subject], content: params[:church][:mail_content])
      render 'invited'
   end
  end


  private

    def donation_params
      params.require(:church).permit(donations_attributes:  [:title,:name, :email, :amount, :stripeToken, :stripe_uid] )
    end
end
