require 'models/searcher'

raise 'Need a search term' unless ARGV.count==1
default_output = 'index.html'

query = ARGV.first
presenter = SearchPresenter.new(
  :searcher => Searcher.new(query),
  :fixed_width => 800)
presenter.write_thumbnail_grid_html default_output