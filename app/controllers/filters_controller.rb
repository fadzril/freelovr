class FiltersController < ApplicationController
  def searcher
    @searcher = User.all.map(&:name)
    render :json => @searcher
  end

  def index
    @query = request.query_string
    @result = User.find_by_sql("SELECT name,id FROM users WHERE name LIKE '%#{@query}%'")
    @autocomplete = []
    @result.each do |result|
       @autocomplete << {:id => result.id, :value => result.name, :label => result.name}
    end

    respond_to do |format|
      format.json { render :json => @autocomplete }
    end
  end
end
