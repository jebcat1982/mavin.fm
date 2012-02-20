FactoryGirl.define do
  factory :album do
    url  'http://featurelessghost.bandcamp.com/album/new-moods'
  end

  factory :playlist do
    search_term 'alternative'
  end
end
