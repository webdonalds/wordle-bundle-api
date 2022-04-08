class UserAuthentication < ApplicationRecord
  belongs_to :user, optional: true
end
