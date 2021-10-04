class SaveDrawType < SaveDraw

  def endpoint
    "#{ENV['CORE_API_ENDPOINT']}/api/loto/draw_type"
  end

end