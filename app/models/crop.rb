class Crop < ApplicationRecord
  has_rich_text :content
  validates_presence_of :title

  def shape_to_json
    if shape.present?
      RGeo::GeoJSON.encode(shape)
    else
      nil
    end
  end
end
