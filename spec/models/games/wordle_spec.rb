require "rails_helper"

describe Games::Wordle do
  let(:user) { FactoryBot.create :user }
  let(:game) { Games::Wordle.create(user: user, raw_result: raw_result) }
  let(:cleared_tries) {
    [
      %i(not_exists wrong_position not_exists not_exists wrong_position),
      %i(not_exists not_exists not_exists not_exists not_exists),
      %i(wrong_position not_exists not_exists not_exists not_exists),
      %i(matched not_exists not_exists matched matched),
      %i(matched matched not_exists matched matched),
      %i(matched matched matched matched matched),
    ]
  }

  describe "#parse" do
    subject { game.parse }

    shared_examples "parse a cleared game" do
      it { expect(subject).to have_attributes(round: 289, try: 6, tries: cleared_tries) }
    end

    context "cleared" do
      let(:raw_result) {
        <<~TEXT
          Wordle 289 6/6

          ⬜🟨⬜⬜🟨
          ⬜⬜⬜⬜⬜
          🟨⬜⬜⬜⬜
          🟩⬜⬜🟩🟩
          🟩🟩⬜🟩🟩
          🟩🟩🟩🟩🟩
        TEXT
      }

      it_behaves_like "parse a cleared game"
    end

    context "cleared (dark mode)" do
      let(:raw_result) {
        <<~TEXT
          Wordle 289 6/6

          ⬛🟨⬛⬛🟨
          ⬛⬛⬛⬛⬛
          🟨⬛⬛⬛⬛
          🟩⬛⬛🟩🟩
          🟩🟩⬛🟩🟩
          🟩🟩🟩🟩🟩
        TEXT
      }

      it_behaves_like "parse a cleared game"
    end

    context "cleared (color blind mode)" do
      let(:raw_result) {
        <<~TEXT
          Wordle 289 6/6

          ⬜🟦⬜⬜🟦
          ⬜⬜⬜⬜⬜
          🟦⬜⬜⬜⬜
          🟧⬜⬜🟧🟧
          🟧🟧⬜🟧🟧
          🟧🟧🟧🟧🟧
        TEXT
      }

      it_behaves_like "parse a cleared game"
    end

    context "over maximum trials" do
      let(:raw_result) {
        <<~TEXT
          Wordle 289 X/6

          ⬛🟨⬛⬛🟨
          ⬛⬛⬛⬛⬛
          🟨⬛⬛⬛⬛
          🟩⬛⬛🟩🟩
          🟩🟩⬛🟩🟩
          🟩🟩🟨🟩🟩
        TEXT
      }
      let(:uncleared_tries) {
        cleared_tries.pop
        cleared_tries + [%i(matched matched wrong_position matched matched)]
      }

      it "parse a uncleared game" do
        expect(subject).to have_attributes(round: 289, try: -1, tries: uncleared_tries)
      end
    end
  end
end
