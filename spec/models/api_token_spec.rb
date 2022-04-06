require "rails_helper"

describe ApiToken do
  describe ".create_with_user!" do
    before do
      Timecop.freeze
    end

    after do
      Timecop.unfreeze
    end

    let(:user) { FactoryBot.create :user }

    subject { ApiToken.create_with_user!(user) }

    it "should success" do
      expect { subject }
        .to change { User.count }.by(1)
    end

    it "should have valid expiration time" do
      puts subject.access_key
      expect(subject.expire_at)
        .to be >= (Time.now + ApiToken::ACCESS_KEY_VALID_DAYS.days)
    end
  end
end
