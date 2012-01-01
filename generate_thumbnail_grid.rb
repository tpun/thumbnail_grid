require_relative 'models/searcher.rb'
require_relative 'models/search_presenter.rb'

raise 'Need a search term' unless ARGV.count==1
default_output = 'index.html'

query = ARGV.first
presenter = SearchPresenter.new(Searcher.new(query), 800)
presenter.write_thumbnail_grid_html default_output