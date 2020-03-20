class DisplayChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'display:checkin'
  end

  def unsubscribed
  end
end
