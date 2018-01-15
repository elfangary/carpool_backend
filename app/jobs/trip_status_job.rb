class TripStatusJob < ApplicationJob
  queue_as :default

  def perform(trip)
    # Do something later
    trip.cleanUp
  end
end
