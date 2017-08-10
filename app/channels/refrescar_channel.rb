class RefrescarChannel < ApplicationCable::Channel
  def subscribed
    stream_from "refrescar"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
