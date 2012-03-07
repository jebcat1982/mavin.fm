require 'active_record/validations'

class Music
  include ActiveRecord::Validations
  attr_accessor :url, :raw_tags
  attr_accessor :errors

  validates :url, :presence => true,
                  :format => {  :with => /.*(soundcloud|bandcamp)\.com.*/i,
                                :message => 'You can only submit Soundcloud or Bandcamp links'  }

  validates :raw_tags, :presence => true

  def initialize(url = nil, tags = nil)
    self.url = url
    self.raw_tags = tags
  end

  def save
    uri = URI.parse(self.url)
    split_tags()

    if uri.host && uri.host.index('bandcamp.com')
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
