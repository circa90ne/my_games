class GamesController < ApplicationController
  before_action :set_api
  before_action :set_game, only: [:edit, :show, :update]

  def index
    @games = @game_api.get_all_games
  end

  def new
    @game = {}
  end

  def show
    # tried to show a game that doesn't exist
    if @game[:error] == GameApi::ERRORS[:NOT_FOUND]
      redirect_to games_url, flash: {error: @game[:error]}
    end
  end

  def edit
    # tried to edit a game that doesn't exist
    if @game[:error] == GameApi::ERRORS[:NOT_FOUND]
      redirect_to games_url, flash: {error: @game[:error]}
    end
  end

  def create
    title = params[:title]
    new_game = @game_api.create(game_params)

    if new_game[:error]
      # Invalid Save so we send them back the 'new' page w/ error msg
      flash[:error] = new_game[:error]
      render :new
    else
      redirect_to games_url, notice: "Game: '#{title}' successfully created."
    end
  end

  def update
    title = params[:title]
    updated = @game_api.update(game_params)

    if updated[:error]
      # Invalid Update so we send them back the 'edit' page w/ error msg
      flash[:error] = updated[:error]
      render :edit
    else
      redirect_to games_url, notice: "Game: '#{title}' successfully updated."
    end
  end

  def destroy
    @game_api.remove(params[:id])
    redirect_to games_url, notice: 'Game was successfully deleted.'
  end

  def search
    if params[:title].blank?
      redirect_to games_url
    else
      search_params = {title: params[:title], category_id: params[:category_id]}
      @games = @game_api.search_for(search_params)

      render :index
    end
  end

  private

    def set_api
      @game_api = GameApi.new
    end

    def set_game
      @game = @game_api.get_game(params[:id])
    end

    def game_params
      params.permit(:id, :category_id, :title, :description, :author, :status)
    end
end
