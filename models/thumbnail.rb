class Thumbnail
  attr_reader :url, :width, :height
  def initialize url, width, height
    @url = url
    @width = width
    @height = height
  end

  def new_height width_adjustment
    to_width = width_adjustment + @width
    Integer (@height * to_width / @width.to_f)
  end

  def resize! width_adjustment
    # This is smelly since we could introduce bug if we swap
    # the order of these two lines.
    @height = new_height width_adjustment
    @width += width_adjustment
  end
end