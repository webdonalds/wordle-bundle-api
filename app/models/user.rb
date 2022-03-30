class User < ApplicationRecord
  has_many :authentications, class_name: "UserAuthentication"
  has_many :api_tokens
end
