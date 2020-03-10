class PagesController < ApplicationController

  def home
    redirect_to diaries_path if logged_in?
  end

  # def about
  # end

  # def contact  
  # end
end