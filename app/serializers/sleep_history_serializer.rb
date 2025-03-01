class SleepHistorySerializer
  include JSONAPI::Serializer

  belongs_to :user

  attributes :id, :clock_in, :clock_out, :duration
end
