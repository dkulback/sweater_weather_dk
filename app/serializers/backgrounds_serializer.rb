class BackgroundsSerializer
  def self.photo(backgrounds, location)
    {
      "data": {
        "type": 'image',
        "id": nil,
        "attributes": {
          "image": {
            "location": location,
            "image_url": backgrounds[:photos][0][:url],
            "image_src": backgrounds[:photos][0][:src][:medium],
            "credit": {
              "author": backgrounds[:photos][0][:photographer],
              "source": 'pexels.com'
            }
          }
        }
      }
    }
  end
end
