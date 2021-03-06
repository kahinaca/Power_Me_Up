class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def profile
  	if current_user.is_hero 
  		@number_of_pending_rentals = Rental.joins(:power).where(status: nil , powers: {user: current_user}).count 
  	   render "hero" 
  	 else 
      @rentals = current_user.rentals   
      render "human"
  	end	
  end

  def home
    @top_powers = Power.all.to_a.sort_by { |power| - power.rentals.count }.first(10)
  end
end
