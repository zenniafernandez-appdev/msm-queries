class CharactersController < ApplicationController

  def character_index
    #@list_of_characters = Character.all
    #@actor_role = Characters.where({ :actor_id => @the_actor })
  end

end

#    @oldest_director = Director.where.not({ :dob => nil}).order({ :dob => :asc }).at(0)
