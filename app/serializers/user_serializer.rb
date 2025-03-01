class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  cache_options store: Rails.cache, namespace: "user", expires_in: 1.hour
end
