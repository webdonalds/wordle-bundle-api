class Game < ApplicationRecord
  include UuidGeneratable

  belongs_to :user
end
