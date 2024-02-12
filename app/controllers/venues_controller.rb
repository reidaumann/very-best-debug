class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    new_venue = Venue.new
    input_address=params.fetch("query_address")
    input_name=params.fetch("query_name")
    input_neighborhood=params.fetch("query_neighborhood")

    new_venue.address = input_address
    new_venue.name = input_name
    new_venue.neighborhood = input_neighborhood
    new_venue.save

    the_id=new_venue.id

    redirect_to("/venues/"+the_id.to_s)
  end
  
  def update
    the_id=params.fetch("the_id")
    input_address=params.fetch("query_address")
    input_name=params.fetch("query_name")
    input_neighborhood=params.fetch("query_neighborhood")

    matching_venues=Venue.where({:id => the_id})
    the_venue=matching_venues.at(0)

    the_venue.address=input_address
    the_venue.name=input_name
    the_venue.save
    
    redirect_to("/venues/"+the_id)
  end

  def destroy
    the_id = params.fetch("the_id")
    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)
    the_venue.destroy

    redirect_to("/venues")
  end

end
