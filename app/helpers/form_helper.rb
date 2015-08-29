module FormHelper
  def setup_user(user)
    user.church ||= Church.new
    user
  end
  
  def preview_link(instance)
    if instance.church.slug
      link_to "Preview of donation page",  church_path(instance.church),  :class => "btn btn-primary" ,  :target => '_blank', :role => "button" 
    end
  end
   def invite_link(instance)
    if instance.church.slug
      link_to "Send out invitations!",  invite_churches_path(instance.church.slug),  :class => "btn btn-primary",  :target => '_blank', :role => "button" 
    end
  end
end