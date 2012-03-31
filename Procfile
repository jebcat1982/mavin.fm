web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: QUEUE=* rake environment resque:work
