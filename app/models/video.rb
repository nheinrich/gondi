class Video < ActiveRecord::Base

  has_and_belongs_to_many :athletes

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
      athletes << athlete
    end
  end

  def existing_athletes=(task_attributes)
    athletes.reject(&:new_record?).each do |task|
      attributes = task_attributes[task.id.to_s]
      if attributes
        task.attributes = attributes
      else
        tasks.delete(task)
      end
    end
  end


end
