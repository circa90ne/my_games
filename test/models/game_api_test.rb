require 'test_helper'

class GameApiTest < ActiveSupport::TestCase
  setup do
    @game_api = GameApi.new
  end

  test 'gets all games' do
    response = {parsed_response: ['one', 'two']}

    response.expects(:parsed_response).with.returns(response[:parsed_response])
    GameApi.expects(:get).with('/games.json').returns(response)

    assert_equal ['one', 'two'], @game_api.get_all_games
  end

  test 'gets game' do
    id = 1
    response = {parsed_response: {id: 1, title: 'game', category_id: 1}}
    game = {id: 1, title: 'game', category_id: 1}

    GameApi.expects(:get).with("/games/#{id}.json").returns(response)
    response.expects(:parsed_response).with.returns(response[:parsed_response])
    response.expects(:code).with.returns(200)

    assert_equal game, @game_api.get_game(id)
  end

  test 'removes game' do
    id = 1
    games = [
      {id: 1, title: 'game', category_id: 1},
      {id: 2, title: 'game', category_id: 1}
    ]
    games_after = [{id: 2, title: 'game', category_id: 1}]

    GameApi.expects(:delete).with("/games/#{id}.json").returns(games_after)

    assert_equal games_after, @game_api.remove(id)
  end

  test 'creates game' do
    title = 'new game'
    game = {id: 1, title: title, category_id: 1}
    params = {title: title, category_id: 1}
    game_params = {query: {game: params}}
    response = {parsed_response: game}

    GameApi.expects(:post).with('/games.json', game_params).returns(response)
    response.expects(:parsed_response).with.returns(response[:parsed_response])
    response.expects(:code).with.returns(200)

    assert_equal game, @game_api.create(params)
  end

  test 'updates game' do
    title = 'game'
    id = 1
    params = {
      id: id,
      title: title,
      category_id: 2,
      author: 'me',
      description: 'words',
      status: 0
    }
    original_game = {
      id: id,
      title: title,
      category_id: 1,
      author: 'not me',
      description: 'words',
      status: 1
    }
    # assigning 'updated_game' variable For readability of test
    updated_game = params
    game_params = {query: {game: params}}
    response = {parsed_response: params}

    GameApi.expects(:put).with("/games/#{id}.json", game_params).returns(response)
    response.expects(:parsed_response).with.returns(response[:parsed_response])
    response.expects(:code).with.returns(200)

    assert_equal updated_game, @game_api.update(params)
  end
end
