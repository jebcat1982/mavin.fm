class Tagging < ActiveRecord::Base
  belongs_to :album
  belongs_to :tag
end
