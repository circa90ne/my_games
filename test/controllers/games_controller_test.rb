require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get games_url
    assert_response :success
  end

  test 'should get new' do
    get new_game_url
    assert_response :success
  end
end
