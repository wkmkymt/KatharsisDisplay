class DisplayChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'display:master'
  end

  def unsubscribed
  end
end
