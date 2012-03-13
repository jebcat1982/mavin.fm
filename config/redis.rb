module Discovery
  def self.redis
    @redis ||= Redis.new
  end
end
