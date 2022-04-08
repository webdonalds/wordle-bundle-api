module UuidGeneratable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uuid, on: :create

    private

    def generate_uuid
      self.uuid = SecureRandom.uuid unless self.uuid.present?
    end
  end
end
