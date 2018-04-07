class CategoryApi
  include HTTParty

  ERRORS = {
    NOT_FOUND: 'CATEGORY NOT FOUND',
    INVALID: 'INVALID TITLE'
  }
  # all API calls will use this as base
  base_uri 'http://gamelibrary.com:3000/v1'
  # hit categories API backend & get parsed response
  def get_categories
    response = self.class.get('/categories.json')
    categories = response.parsed_response
  end
  # query Category API for specific category
  def get_category(id)
    response = self.class.get("/categories/#{id}.json")
    category = response.code == 404 ? {error: ERRORS[:NOT_FOUND]} : response.parsed_response
  end
  # Remove a category via API
  def remove(id)
    response = self.class.delete("/categories/#{id}.json")
  end
  # Create a new category via API
  def create(name)
    params = {query: {category: {name: name}}}
    response = self.class.post("/categories.json", params)
    category = response.code == 422 ? {error: ERRORS[:INVALID]} : response.parsed_response
  end
end
