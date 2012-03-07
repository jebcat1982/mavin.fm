class Music
  attr_accessor :url, :tags, :album_id

  def initialize(url = nil, tags = nil)
    self.url = url
    self.tags = tags
  end

  def save
    uri = URI.parse(self.url)

    if uri.host.index('bandcamp.com')
      b = Bandcamp.new(url, tags)
      b.save
    elsif uri.host.index('soundcloud.com')
      s = Soundcloud.new(url, tags)
      s.save
    end
  end

  def split_tags
    @tags = []
    self.tags.split(' ').map do |name|
      @tags << Tag.find_or_create_by_name(name.chomp)
    end
  end
end
