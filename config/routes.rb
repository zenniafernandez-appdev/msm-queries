Rails.application.routes.draw do
  get("directors/eldest", { :controller => "directors", :action => "wisest" })

  get("directors/youngest", { :controller => "directors", :action => "youngest" })

  get("/", { :controller => "application", :action => "homepage" })

  get("/directors", { :controller => "directors", :action => "index" })
  
  get("/directors/:an_id", { :controller => "directors", :action => "director_details" })

  get("/movies", { :controller => "movies", :action => "movie_index"})
  
  get("/movies/:m_id", { :controller => "movies", :action => "m_details" })
  
  get("/actors", { :controller => "actors", :action => "actor_index" })

  get("/actors/:act_id", { :controller => "actors", :action => "actor_details" })
end
