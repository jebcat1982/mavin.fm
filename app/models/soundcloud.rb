class Soundcloud
  attr_accessor :url, :raw_tags

  def initialize(url = nil, tags = nil)
    self.url  = url
    self.raw_tags = tags
  end

  def split_tags
    @tags = []
    raw_tags.split(' ').map do |name|
      @tags << Tag.find_or_create_by_name(name.chomp)
    end
  end
end
