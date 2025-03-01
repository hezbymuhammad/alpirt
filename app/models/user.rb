class User < ApplicationRecord
  has_many :sleep_histories

  has_many :follower_circles, class_name: "Circle", foreign_key: "following_id", dependent: :destroy
  has_many :following_circles, class_name: "Circle", foreign_key: "user_id", dependent: :destroy
  has_many :followers, through: :follower_circles, source: :user
  has_many :followings, through: :following_circles, source: :following

  def sleep(sleep_time = DateTime.current)
    sleep_histories.create(
      clock_in: sleep_time
    ).valid?
  end

  def wake_up(wake_up_time = DateTime.current)
    sleep_histories.incompleted.last&.update(
      clock_out: wake_up_time
    )
  end

  def follow(user)
    following_circles.find_or_create_by(following: user).valid?
  end

  def unfollow(user)
    circle = following_circles.find_by(following: user)
    circle&.destroy
  end

  def following?(user)
    following_circles.where(following: user).exists?
  end
end
