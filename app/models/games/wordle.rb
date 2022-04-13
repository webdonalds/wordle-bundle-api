module Games
  class Wordle < Game
    attr_accessor :round, :try, :tries

    SCORE_PATTERN = /Wordle (?<round>\d+) (?<try>\d|X)\/6/

    MATCHED        = :matched
    WRONG_POSITION = :wrong_position
    NOT_EXISTS     = :not_exists
    CHARS          = {
      MATCHED        => ["🟩", "🟧"],
      WRONG_POSITION => ["🟨", "🟦"],
      NOT_EXISTS     => ["⬛", "⬜"],
    }

    def parse
      lines = raw_result.split("\n").map(&:strip)
      SCORE_PATTERN.match(lines.shift).tap { |r| raise "Failed to parse result" if r.nil? }.then do |parsed|
        @round = parsed[:round].to_i
        @try   = parsed[:try].then { |try| try == "X" ? -1 : try.to_i }
      end

      lines.select!(&:present?)
      raise "Failed to parse result (try count not matched)" if (@try != -1) && (lines.count != @try)

      @tries = lines.map do |line|
        line.chars.map do |c|
          CHARS.select { |_, expected| expected.include?(c) }.keys.first
               .tap    { |i| raise "Failed to parse result (invalid character)" if i.nil? }
        end
      end

      self
    end
  end
end
