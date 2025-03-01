class User < ApplicationRecord
  has_many :sleep_histories

  def sleep(sleep_time = DateTime.current)
    sleep_histories.create(
      clock_in: sleep_time
    )
  end

  def wake_up(wake_up_time = DateTime.current)
    sleep_histories.incompleted.last.update(
      clock_out: wake_up_time
    )
  end
end
