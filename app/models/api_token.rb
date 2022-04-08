class ApiToken < ApplicationRecord
  belongs_to :user

  ACCESS_KEY_VALID_DAYS  = 7
  REFRESH_KEY_VALID_DAYS = 30

  def self.create_with_user!(user)
    access_key  = JWT.encode({ user_id: user.uuid, exp: ACCESS_KEY_VALID_DAYS.days.from_now.to_i }, secret_key)
    refresh_key = JWT.encode({ user_id: user.uuid, exp: REFRESH_KEY_VALID_DAYS.days.from_now.to_i }, secret_key)
    create!(user: user, access_key: access_key, refresh_key: refresh_key, expire_at: ACCESS_KEY_VALID_DAYS.days.from_now)
  end

  def self.secret_key
    @secret_key ||= Figaro.env.SERVER_SECRET_KEY
  end
end
