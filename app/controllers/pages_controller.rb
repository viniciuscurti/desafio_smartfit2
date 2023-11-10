class PagesController < ApplicationController
  def home
    @locations = Location.all
  end
end
