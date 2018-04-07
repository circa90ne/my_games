require 'test_helper'

class CategoryApiTest < ActiveSupport::TestCase
  setup do
    @category_api = CategoryApi.new
  end

  test 'gets categories' do
    response = {parsed_response: ['one', 'two']}

    response.expects(:parsed_response).with.returns(response[:parsed_response])
    CategoryApi.expects(:get).with('/categories.json').returns(response)

    assert_equal ['one', 'two'], @category_api.get_categories
  end

  test 'gets category' do
    id = 1
    response = {parsed_response: {id: 1, name: 'category'}}
    category = {id: 1, name: 'category'}

    CategoryApi.expects(:get).with("/categories/#{id}.json").returns(response)
    response.expects(:parsed_response).with.returns(response[:parsed_response])
    response.expects(:code).with.returns(200)

    assert_equal category, @category_api.get_category(id)
  end

  test 'removes category' do
    id = 1
    categories = [{id: 1, name: 'category'}, {id: 2, name: 'category2'}]
    categories_after = [{id:2, name: 'category2'}]

    CategoryApi.expects(:delete).with("/categories/#{id}.json").returns(categories_after)

    assert_equal categories_after, @category_api.remove(id)
  end

  test 'creates category' do
    name = 'new category'
    category = {id: 1, name: name}
    params = {query: {category: {name: name}}}
    response = {parsed_response: category}

    CategoryApi.expects(:post).with('/categories.json', params).returns(response)
    response.expects(:parsed_response).with.returns(response[:parsed_response])
    response.expects(:code).with.returns(200)

    assert_equal category, @category_api.create(name)
  end
end
