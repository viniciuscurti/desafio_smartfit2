class FindBySchedule
  def initialize(params)
    @hours = params[:hours]
  end

  def call
    Location.where("schedules ->> 'hours' = ?", @hours)
  end
end
