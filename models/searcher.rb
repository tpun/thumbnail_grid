class Searcher
  attr_reader :query
  def initialize query
    @query = query
  end

  def results
    []
  end
end