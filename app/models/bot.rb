class Bot < ActiveRecord::Base
  has_attached_file :source
  validates_presence_of :source
  validates_presence_of :player_name

  validates_attachment_content_type :source, content_type: ['application/zip', 'application/x-zip', 'application/x-zip-compressed']

  def self.active
    where(status: "active")
  end

  def won_against!(adversary_bot)
    new_score = get_new_score(1, adversary_bot)
    adversary_score = adversary_bot.get_new_score(0, self)

    self.wins += 1
    self.score = new_score
    save!

    adversary_bot.losses += 1
    adversary_bot.score = adversary_score
    adversary_bot.save!
  end

  def drew_against!(adversary_bot)
    new_score = get_new_score(0.5, adversary_bot)
    adversary_score = get_new_score(0.5, self)

    self.draws += 1
    self.score = new_score
    save!

    adversary_bot.draws += 1
    adversary_bot.score = adversary_score
    adversary_bot.save!
  end

  ###
  # Scoring
  ###

  def get_new_score( points, adversary_bot )
    handicap = 50
    expected_score = probability_of_win(adversary_bot)
    adjusted_points = handicap * (points.to_f - expected_score)
    new_score = score + adjusted_points
  end

  def probability_of_win( adversary_bot )
    adjusted_probability_score / (adjusted_probability_score + adversary_bot.adjusted_probability_score)
  end

  def adjusted_probability_score
    10**(self.score.to_f / 400)
  end
end
