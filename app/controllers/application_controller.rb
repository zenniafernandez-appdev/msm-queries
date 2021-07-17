class ApplicationController < ActionController::Base
  def homepage
    render({ :template => "misc_templates/home"})
  end
end
