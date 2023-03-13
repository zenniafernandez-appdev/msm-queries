class MoviesController < ApplicationController

  def movie_index
  @list_of_movies = Movie.all

  render({ :template => "movie_templates/movie_list.html.erb" })
  end

  def m_details
    mv_id = params.fetch("m_id")
    @the_movie = Movie.where({ :id => mv_id }).at(0)

    render({ :template => "movie_templates/movie_details.html.erb" })
  end
end
    
