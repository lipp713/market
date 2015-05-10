class PagesController < ApplicationController
  def home
  	#if user_signed_in?
        #    redirect_to backoffice_path
        #else
        #    redirect_to new_user_session_path
        #end

  	if current_user
	    redirect_to products_path
	  end
  end
end
