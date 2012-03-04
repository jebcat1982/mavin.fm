class Tagging < ActiveRecord::Base
  belongs_to :album
  belongs_to :tag
  belongs_to :track
end
