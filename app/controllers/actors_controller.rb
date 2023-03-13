class ActorsController < ApplicationController
  # $list_of_characters = Character.all

  def actor_index
    @list_of_actors = Actor.all

    render({ :template => "actor_templates/actor_list.html.erb" })
  end

  def actor_details
    # Parameters: {"act_id"=>"3"

    a_id = params.fetch("act_id")

    @the_actor = Actor.where({ :id => a_id }).at(0)

    # @a_character = Character.where({ :actor_id => @the_actor.id }).at(0)

    # @a_movie = Movie.where({ :id => @a_character.movie_id }).at(0)

    # @a_director = Director.where({ :id => @a_movie.director_id }).at(0)

    list_of_characters = Character.all
    
    render({ :template => "actor_templates/actor_details.html.erb" })
  end
end
