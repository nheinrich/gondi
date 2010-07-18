class Athlete < ActiveRecord::Base
  has_and_belongs_to_many :videos
  has_friendly_id :name, :use_slug => true
end
