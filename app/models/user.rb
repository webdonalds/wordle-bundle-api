class User < ApplicationRecord
  include UuidGeneratable

  has_many :authentications, class_name: "UserAuthentication"
  has_many :api_tokens
end
