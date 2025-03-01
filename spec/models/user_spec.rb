require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:follower) { create :user }

  describe "#sleep" do
    it "create sleep record with default value" do
      user.sleep

      sleep_history = user.reload.sleep_histories.last
      expect(sleep_history).to be_present
    end

    it "create sleep record with param" do
      time = Faker::Time.backward(days: 14, period: :evening)
      user.sleep time

      sleep_history = user.reload.sleep_histories.last
      expect(sleep_history.clock_in).to eq(time)
    end
  end

  describe "#wake_up" do
    it "create sleep record with default value" do
      user.sleep
      user.wake_up

      sleep_history = user.reload.sleep_histories.last
      expect(sleep_history.clock_out).to be_present
    end

    it "create sleep record with param" do
      time = Faker::Time.backward(days: 14, period: :evening)
      user.sleep time - 5.hours
      user.wake_up time

      sleep_history = user.reload.sleep_histories.last
      expect(sleep_history.clock_out).to eq(time)
    end
  end

  describe "#follow" do
    it "able to follow user" do
      user
      follower

      follower.follow(user)

      expect(follower.followings.last).to eq(user)
    end
  end

  describe "#unfollow" do
    it "able to unfollow user" do
      user
      follower

      follower.follow(user)

      expect(follower.followings.last).to eq(user)

      follower.unfollow(user)

      expect(follower.followings).to be_empty
    end
  end

  describe "#following?" do
    it "able to check following user" do
      user
      follower

      follower.follow(user)

      expect(follower.following?(user)).to be_truthy
    end
  end
end
