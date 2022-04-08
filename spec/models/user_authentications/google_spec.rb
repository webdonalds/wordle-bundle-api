require "rails_helper"

describe UserAuthentications::Google do
  let(:id_token_payload) {
    {
      "sub":   SecureRandom.hex(10),
      "email": Faker::Internet.email,
    }.to_json
  }

  describe ".find_or_create_by_id_token!" do
    context "success" do
      before do
        expect_any_instance_of(GoogleIDToken::Validator).to receive(:check).and_return(id_token_payload)
      end

      subject { UserAuthentications::Google.find_or_create_by_id_token!(SecureRandom.uuid) }

      it "should create new authentication and user" do
        expect { subject }
          .to change { UserAuthentication.count }.by(1)
         .and change { User.count }.by(1)
      end

      it "create authentication with valid attributes" do
        expect(subject)
          .to have_attributes(auth_id: id_token_payload["sub"])
      end

      it "create user with valid attributes" do
        expect(subject.user)
          .to have_attributes(display_name: id_token_payload["email"].split("@").first, email: id_token_payload["email"])
      end
    end
  end
end
