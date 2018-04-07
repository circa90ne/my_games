class CategoriesController < ApplicationController
  before_action :set_api
  before_action :set_categories, only: [:index]
  before_action :set_games, only: [:show]
  before_action :set_category, only: [:show, :edit]

  def index
  end

  def edit
    #tried to show a category that doesn't exist
    if @category[:error] == CategoryApi::ERRORS[:NOT_FOUND]
      redirect_to categories_url, flash: {error: @category[:error]}
    end
  end

  def show
    #tried to edit a game that doesn't exist
    if @category[:error] == CategoryApi::ERRORS[:NOT_FOUND]
      redirect_to categories_url, flash: {error: @category[:error]}
    end
  end

  def new
  end

  def create
    name = params[:name]
    new_category = @category_api.create(name)

    if new_category[:error]
      # Invalid Save so we send them back the 'new' page w/ error msg
      flash[:error] = new_category[:error]
      render :new
    else
      redirect_to categories_url, notice: "Category: '#{name}' successfully created."
    end
  end

  def destroy
    @category_api.remove(params[:id])
    redirect_to categories_url, notice: 'Category was successfully deleted.'
  end

  private
    def set_api
      @category_api = CategoryApi.new
    end
    # populate categories from Categories API
    def set_categories
      @categories = @category_api.get_categories
    end
    # get the correct category for the corresponding id
    def set_category
      @category = @category_api.get_category(params[:id])
    end
    # set games to be all the games in a specific category
    def set_games
      game_api = GameApi.new
      @games = game_api.get_games_by_category(params[:id])
    end
end
