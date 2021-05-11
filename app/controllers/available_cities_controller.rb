class AvailableCitiesController < ApplicationController
  def index
    @available_cities = Restaurant.all.map { |r| r.city }.uniq 
    # o map serve para mapear/filtrar por cidade.
    # o uniq serve para evitar de ficar repetindo 3x a cidade São Paulo, 
    # pq existem 3 restaurantes nesta cidade.
  end
end
