class Video < ActiveRecord::Base

  has_and_belongs_to_many :athletes
  has_attached_file :snapshot, :styles => { :thumb => "144x108>" }

  before_save :set_status

  default_scope :order => 'videos.created_at DESC'
  scope :active, where("status = ?", 'active')

  def set_status
    # todo: set to review if submitted by user
    self.status = 'active'
  end

  def related_athletes=(athlete_names)
    athlete_names.each do |athlete_name|
      athlete = Athlete.find_or_create_by_name(athlete_name)
      athletes << athlete unless athletes.include? athlete
    end
  end

end
