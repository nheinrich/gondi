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

  def save_button(video)
    if user = current_user
      text = user.has_favorited(video) ? 'Saved' : 'Save'
      style = 'save_video ' + text.parameterize('_') + ' video_' + video.id.to_s
      capture_haml do
        haml_tag :a, {:href => favorite_path(video), :class => style, "data-remote" => "true" } do
          haml_tag :span, text, {:class => 'text'}
        end
      end
    else
      capture_haml do
        haml_tag :a, 'Save', { :href => pitch_path,
          :class => 'save_video save', "data-remote" => "true" }
      end
    end
  end

end
