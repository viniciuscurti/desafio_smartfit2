class Updater
  def initialize(location, attributes)
    @location = location
    @attributes = attributes
  end

  def update
    @location.update(@attributes)
  end
end
