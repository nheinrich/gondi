module VideoHelper

  def fields_for_athlete(athlete, &block)
    prefix = athlete.new_record? ? 'new' : 'existing'
    haml_capture do
      fields_for("video[#{prefix}_athlete_attributes][]", athlete, &block)
    end
  end

end
