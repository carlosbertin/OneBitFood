class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: :show
  def index
    @restaurants = Restaurant.all
    filter_by_query if params[:q]
    filter_by_city if params[:city]
    filter_by_category if params[:category]
  end

  def show
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def filter_by_query
    # este método utiliza a gem ransack que implementa os filtros.
    # neste caso, o filtro será feito por nome ou descrição do restaurante.
    # o _cont (de name_or_description_cont) é um padrão que deve ser utilado nesta gem
    # .result serve para pegar o resultado desta linha de comando.
    # no index, a cláusula filter_by_query if params[:q] acionará este método
    # se o params[:q] estiver preenchido.
    @restaurants = @restaurants.ransack(name_or_description_cont: params[:q]).result
  end

  def filter_by_city
    @restaurants = @restaurants.where(city: params[:city])
  end

  def filter_by_category
    # neste filtro, como o que deve ser buscado é pela tabela pai
    # do restaurante, pois cada restaurante está acoplado a uma categoria,
    # é feito uma seleção (select) dos restaurantes que pertencem a 
    # categoria que se deseja buscar. O "r" representa cada registro
    # dos restaurantes e é verificada a categoria de cada um. Neste caso,
    # é passado r.category.title, pois "r" é o objeto, category é a classe 
    # Categories e title o campo texto que representa o título da 
    # categoria. Isto é necessário, pois o que o usuário vai passar no filtro
    # é o nome da categoria e não o id da categoria.
    @restaurants = @restaurants.select do |r|
      r.category.title == params[:category]
    end
  end
end
