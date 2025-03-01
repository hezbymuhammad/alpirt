class SleepHistorySerializer
  include JSONAPI::Serializer

  belongs_to :user

  attributes :id, :clock_in, :clock_out, :duration

  cache_options store: Rails.cache, namespace: 'sleep-history', expires_in: 1.hour
end
