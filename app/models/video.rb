class Video < ActiveRecord::Base

  has_attached_file :snapshot, :styles => { :thumb => "144x108>" }
  has_friendly_id :title, :use_slug => true

  has_and_belongs_to_many :athletes
  has_many :favorites, :dependent => :destroy
  has_many :user_favorites, :through => :favorites, :source => :user

  has_many :views, :dependent => :destroy
  has_many :user_views, :through => :views, :source => :user

  default_scope :order => 'videos.published_at DESC'
  scope :active, where("status = ? AND published_at <= ?", 'active', Time.now)

  def related_athletes=(athlete_names)
    # create a list of all existing athletes
    diff = athletes.map(&:name)
    athlete_names.each do |name|
      # see if an existing athlete exists, if not create one
      athlete = Athlete.find_or_create_by_name(name)
      unless athletes.include? athlete
        # add athlete to athletes
        athletes << athlete
      else
        # remove athlete from diff list
        diff.delete_if { |a| a == athlete.name }
      end
    end
    # delete all athletes that are no longer related
    athletes.delete(Athlete.find_all_by_name(diff))
  end

  def total_views
    views.map(&:total).sum
  end
end
