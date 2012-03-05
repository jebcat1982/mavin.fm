class Soundcloud
  attr_accessor :url, :tags

  def initialize(url = nil, tags = nil)
    self.url  = url
    self.tags = tags
  end
end
