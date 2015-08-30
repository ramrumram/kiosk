class ChurchesController < ApplicationController
   def show
      @church = Church.friendly.find(params[:id])
   end
   
def new
  @church = Project.new
end
   
  def update
     @church = Church.friendly.find(params[:id])
     if @church.update(donation_params)
        render 'success'
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
      params.require(:church).permit(donations_attributes:  [:title,:name, :email, :amount,] )
    end
end