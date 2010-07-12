class Video < ActiveRecord::Base

  before_save :set_status

  default_scope :order => 'videos.created_at DESC'
  scope :active, where("status = ?", 'active')

  def set_status
    # todo: set to review if submitted by user
    self.status = 'active'
  end

end
