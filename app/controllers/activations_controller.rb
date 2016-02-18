class ActivationsController < ApplicationController
  def new
  params = {"accttype"=>"VISA","orderid"=>"AB-11-9876","account"=>"4111111111111111","expiry"=>"1218","amount"=>"1.0","currency"=>"USD","name"=>"TOM JONES","address"=>"123 MAINSTREET","city"=>"anytown","region"=>"NY","country"=>"US","postal"=>"55555","ecomind"=>"E","cvv2"=>"123","tokenize"=>"N"}
  service = CardConnect::Service::Authorization.new
  service.build_request(params)
  response = service.submit

  
  if(response.respstat == "A")
      #response.retref
      params = {"retref" => response.retref, "items" => [{"description" => "DESCRIPTION-1"}]}
      service = CardConnect::Service::Capture.new
      service.build_request(params)
      response = service.submit
      logger.info response.inspect
  end if










    #logger.info params.inspect

    #logger.info response.inspect

     @activation = Activation.new
  end

  def create
     @activation = Activation.new(activation_params)
     if @activation.save
       ActivationMailer.activation_email(@activation)

       render "success"
     end
  end

  private
  def activation_params
    params.require(:activation).permit(:title, :name, :phone, :email)
  end
end
