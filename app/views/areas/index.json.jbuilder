json.array!(@areas) do |area|
  json.extract! area, :id, :areacode, :latitude, :longitude, :address, :description, :title
  json.url area_url(area, format: :json)
end
