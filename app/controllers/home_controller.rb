# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @events_counter = EventsCounterService.new(current_user) if current_user
  end
end
