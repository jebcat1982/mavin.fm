# Mavin.fm

Mavin.fm is a music discovery app for Bandcamp and Soundcloud. Artists would submit their music to the index and users could listen to music by independent artist based on genres or tags that they're interested in.

## Setup

### Dependencies

Mavin.fm makes use of Redis and Postgres for data storage. Redis is used for the background worker that processes the music added into the index in addition to being used to decide the next song to play.

On OS X

```
$ brew install postgres
$ brew install redis
```

### Getting up and running

Getting up and running is pretty easy.

```
$ git clone git://github.com/tomelm/mavin.fm.git
$ cd mavin.fm
$ bundle install
$ rake db:schema:load
$ redis-server &
$ foreman start
```

Note: you will need Bandcamp and SoundCloud API keys. At the moment, Bandcamp is not giving anymore API keys but you can get a SoundCloud key here: http://developers.soundcloud.com/

## Other

### Data currently stored in Redis

There are several groups of data being stored in Redis. Here is a list of the keys and what they're using:

```
tracks  = set  of all of the current tracks
p{id}   = set  of tag ids attached to a current playlist
pts{id} = set  of recently played playlist tracks
ptw{id} = hash of tag weights for a playlist
t{id]   = set  of tags for the track
```

### Technology used

1. Redis
2. Backbone.js

## To do

1. Tests (started in v3)
2. Improve next song algorithm
3. Spidering for music