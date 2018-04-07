class GameApi
  include HTTParty

  ERRORS = {
    NOT_FOUND: 'GAME NOT FOUND',
    INVALID: 'INVALID CATEGORY'
  }
  # all API calls will use this as base
  base_uri 'http://gamelibrary.com:3000/v1'
  # query games API for all games in specific category
  def get_games_by_category(id)
    response = self.class.get("/games/categories/#{id}.json")
    games = response.parsed_response
  end
  # return all games from game API
  def get_all_games
    response = self.class.get('/games.json')
    games = response.parsed_response
  end
  # query Game API for specific category
  def get_game(id)
    response = self.class.get("/games/#{id}.json")
    game = response.code == 404 ? {error: ERRORS[:NOT_FOUND]} : response.parsed_response
  end
  # delete a game using game API
  def remove(id)
    response = self.class.delete("/games/#{id}.json")
  end
  # create a new game
  def create(params)
    game_params = {query: {game: params}}
    response = self.class.post("/games.json", game_params)
    game = response.code == 422 ? {error: ERRORS[:INVALID]} : response.parsed_response
  end
  # edit an existing game
  def update(params)
    id = params[:id]
    game_params = {query: {game: params}}
    response = self.class.put("/games/#{id}.json", game_params)
    game = response.code == 422 ? {error: ERRORS[:INVALID]} : response.parsed_response
  end
  # search for games with specific title/category
  def search_for(params)
    search_params = {query: params}
    response = self.class.get("/games/search.json", search_params)
    games = response.parsed_response
  end
end
