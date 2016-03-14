class KiosksController < ApplicationController
   def show
      @kiosk = Kiosk.find(params[:id])
      @user = User.find(@kiosk.user_id)



      # if it is a test preview
      if (params[:id] == "9")
    		@name = "Jason Smith"
        @CVV = 324
        @email = "jsmith1@startgroup.org"
        @testcard = "4000000000000077"
      end
   end

def new
  @kiosk = Project.new
end

  def update
    begin
       id = params[:id]
       kiosk = Kiosk.find(id)

       number = params[:number]
       cvc = params[:cvc]
       exp_mn = params[:exp_mn].to_s
       exp_yr = params[:exp_yr].to_s
       amount = params[:kiosk][:donations_attributes]["0"][:amount]
       name = params[:kiosk][:donations_attributes]["0"][:name]
       email = params[:kiosk][:donations_attributes]["0"][:email]

       pay_params = {"merchid" => kiosk.user.merchid, "account"=>number,"expiry"=>exp_mn+exp_yr,"amount"=>amount,"currency"=>"USD","name"=>name, "ecomind"=>"E","cvv2"=>cvc,"tokenize"=>"N"}

       service = CardConnect::Service::Authorization.new
       service.build_request(pay_params)

       begin
         response = service.submit
         if(response.respstat == "A")
          string_email = ""
           if !email.blank? && email != ""
             string_email = "from "+email
           end

          pay_params = {"merchid" => kiosk.user.merchid,"retref" => response.retref, "items" => [{"description" => "Donation for "+kiosk.title + string_email}]}


          begin
            #completely a test account
        #    if (id == "1000")
          #      @response = {"status" => "! <p class='small'>Thank you very much. The page will reset in 3 seconds.</p> "}

          #  else

                service = CardConnect::Service::Capture.new
                service.build_request(pay_params)
                response = service.submit
                @response = {"status" => "! "+response.setlstat, "retref" => response.retref}
                if (response.setlstat != 'Rejected')

                  params[:kiosk][:donations_attributes]["0"][:cardconnectref] = response.retref


                  if kiosk.update(donation_params)
                    if !email.blank? && email != ""
                        charge = {"email" => email, "name" => name,"amount" => amount, "retref" => response.retref }
                        KioskMailer.receipt_email(charge).deliver
                    end

                    charge = {"email" => kiosk.user.email,"amount" => amount,"kiosk_name" => kiosk.title}
                    KioskMailer.owner_email(charge).deliver
                  end
                  #is Rejected
                else
                  @response = {"errors" => "Request Declined! "+response.setlstat}
                end


          # if ! 1000
        #  end

          rescue Exception => msg
             @response = {"errors" => "Error in connection / Merchant id wrong"}
          end

        #respstat is not 'A'
      else
        @response = {"errors" => "Request Declined! "+response.errors.join(",")}
        end


       rescue Exception => msg
           @response = {"errors" => "Error in connection / Merchant id wrong"}
       end





      respond_to do |format|
            format.js  {}
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
      params.require(:kiosk).permit(donations_attributes:  [:title,:name, :email, :amount, :cardconnectref] )
    end
end
