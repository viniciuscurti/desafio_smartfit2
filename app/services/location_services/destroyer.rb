module LocationServices
  class Destroyer
    def self.call(location)
      location.destroy
    end
  end
end
