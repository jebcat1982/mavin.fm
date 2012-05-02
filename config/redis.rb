module Discovery
  def self.redis
    if ENV["REDISTOGO_URL"]
      uri = URI.parse(ENV["REDISTOGO_URL"])
      @redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      @redis ||= Redis.new
    end
  end

  def self.bench(desc)
    start = Time.now
    yield
    puts "#{desc} #{Time.now-start} seconds"
  end
end
