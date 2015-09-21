class ChurchesController < ApplicationController
   def show
      @church = Church.friendly.find(params[:id])
   end
   
def new
  @church = Project.new
end
   
  def update
    
    begin
     desc = params[:church][:donations_attributes]["0"][:name] +" " + params[:church][:donations_attributes]["0"][:email] + " for " + params[:id] 
     token = params[:stripeToken]
      amount = params[:church][:donations_attributes]["0"][:amount].to_f * 100 
     amount = amount.to_i
      
       charge = Stripe::Charge.create(
      :amount => amount, # amount in cents, again
       :currency => "usd",
       :source => token,
      :description => desc
    )
   rescue Stripe::CardError => e
   else 
   
    @church = Church.friendly.find(params[:id])
     
    logger.info "wattt"
    logger.info "incoming" 
     if @church.update(donation_params)
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
      params.require(:church).permit(donations_attributes:  [:title,:name, :email, :amount, :stripeToken] )
    end
end
