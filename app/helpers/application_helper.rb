module ApplicationHelper  # put helpers here
  # helpers are functions for use in views (remember, in Rails views are the templates!)
  
  #  return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
