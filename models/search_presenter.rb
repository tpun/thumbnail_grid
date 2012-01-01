class SearchPresenter
  def initialize searcher, fixed_width
    @searcher = searcher
    @search_results = searcher.results
    @fixed_width = fixed_width
  end

  def items_per_row
    current_width = 0
    [].tap do |items|
      # Pick the right number of items
      while (!@search_results.empty? and
        current_width + @search_results.first.width < @fixed_width)
        items << @search_results.shift
        current_width += items.last.width
      end

      # Pick the thumbnail which results in minimum total row height change
      adjustment = @fixed_width - current_width
      if !@search_results.empty? and adjustment > 0
        resized_heights = items.map {|item| item.new_height adjustment }
        index_min_row_height_change = resized_heights.index resized_heights.min

        items[index_min_row_height_change].resize! adjustment
      end
    end
  end

  def write_thumbnail_grid_html filename
    html = File.new filename, 'w'
    html.write '<html>'
    html.write '<head>'
    html.write '<title>@searcher.query</title>'
    html.write '<style type="text/css">'
    html.write 'img { margin: 0; position: absolute; }'
    html.write '</style>'
    html.write '</head>'

    top = 0
    while !@search_results.empty?
      current_width = 0
      row_height = 0
      items_per_row.each do |image|
        style = "'width:#{image.width}px; left: #{current_width}px; top: #{top}px'"
        html.write "<img style= #{style} src='#{image.url}'>"
        current_width += image.width
        row_height = image.height if image.height > row_height
      end
      top += row_height
    end

    html.write '</body>'
    html.write '</html>'
    html.close
  end
end