class Music
  include ActiveModel::Validations
  attr_accessor :url, :raw_tags

  validates :url, :presence => true,
                  :format => {  :with => /.*(soundcloud|bandcamp)\.com.*/i,
                                :message => 'You can only submit Soundcloud or Bandcamp links'  }

  validates :raw_tags, :presence => true

  def initialize(url = nil, tags = nil)
    @url = url
    @raw_tags = tags
  end

  def save
    if valid?
      uri = URI.parse(self.url)
      split_tags()

      if uri.host && uri.host.index('bandcamp.com')
        b = Bandcamp.new(url, @tags)
        b.save
      elsif uri.host && uri.host.index('soundcloud.com')
        s = Soundcloud.new(url, @tags)
        s.save
      end

      true
    else
      false
    end
  end

  def split_tags
    @tags = []
    if raw_tags.index(',')
      split_tags = raw_tags.split(',')
    else
      split_tags = raw_tags.split(' ')
    end

    split_tags.map do |name|
      @tags << Tag.find_or_create_by_name(name.strip)
    end

    @tags
  end
end
