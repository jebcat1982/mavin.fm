class Bandcamp
  attr_accessor :url

  def initialize(url = nil, tags = nil)
    self.url  = url
    self.tags = tags
  end
end
