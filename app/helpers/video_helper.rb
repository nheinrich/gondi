module VideoHelper

  def fields_for_athlete(athlete, &block)
    prefix = athlete.new_record? ? 'new' : 'existing'
    haml_capture do
      fields_for("video[#{prefix}_athlete_attributes][]", athlete, &block)
    end
  end

  def determine_video_status(video)
    if video
      return video.status || 'active'
    elsif current_admin
      return 'active'
    else
      return 'inactive'
    end
  end

end
