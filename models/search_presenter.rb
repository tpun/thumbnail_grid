class SearchPresenter
  def initialize searcher, fixed_width
    @searcher = searcher
    @fixed_width = fixed_width
  end

  def items_per_row
    current_width = 0
    search_results = @searcher.results
    [].tap do |items|
      # Pick the right number of items
      while (!search_results.empty? and
        current_width + search_results.first.width < @fixed_width)
        items << search_results.shift
        current_width += items.last.width
      end

      # Pick the thumbnail which results in minimum new height change
      # adjustment = @fixed_width - current_width
      # if !search_results.empty? and adjustment>0
      #   resized_heights = items.map {|item| item.new_height adjustment }
      #   index_min_resized_height = resized_height.index resized_heights.min
      #   to_adjust = items[index_min_resized_height]
      #   to_adjust.resize! adjustment
      # end
    end
  end

  def write_thumbnail_grid filename
    file = File.new filename, 'w'
    file.close
  end
end