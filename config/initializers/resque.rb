Resque.redis = Discovery.redis

Dir[Rails.root.join('app', 'jobs', '**', '*.rb')].each do |file| 
  require file
end
