class Music
  attr_accessor :url, :raw_tags

  def initialize(url = nil, tags = nil)
    self.url = url
    self.raw_tags = tags
  end

  def save
    uri = URI.parse(self.url)
    split_tags()

    if uri.hist && uri.host.index('bandcamp.com')
      b = Bandcamp.new(url, @tags)
      b.save
    elsif uri.host && uri.host.index('soundcloud.com')
      s = Soundcloud.new(url, @tags)
      s.save
    end
  end

  def split_tags
    @tags = []
    raw_tags.split(' ').map do |name|
      @tags << Tag.find_or_create_by_name(name.chomp)
    end
  end
end
