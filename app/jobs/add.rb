class Add
  @queue = :music

  def self.perform(url, tags)
    m = Music.new(url, tags)
    m.save
  end
end
