module LocationServices
  class Shower
    def initialize(params)
      @params = params
    end

    def call
      if @params.key?(:uuid)
        @location = Location.find_by(uuid: @params[:uuid])
      else
        @location = Location.find_by(id: @params[:id])
    end
  end
end
