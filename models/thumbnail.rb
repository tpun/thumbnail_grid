class Thumbnail
  attr_reader :url, :width, :height
  def initialize url, width, height
    @url = url
    @width = width
    @height = height
  end

  def new_height to_width
    Integer (@height * to_width / @width.to_f)
  end

  def resize! to_width
    # This is smelly since we could introduce bug if we swap
    # the order of these two lines.
    @height = new_height to_width
    @width = to_width
  end
end