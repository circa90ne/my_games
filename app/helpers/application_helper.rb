module ApplicationHelper
  def to_condensed_options(array)
    condensed_array = array.map { |item| [item['name'], item['id']] }
  end
end
