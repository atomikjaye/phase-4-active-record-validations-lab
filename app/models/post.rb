class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, { :length => { :minimum => 250 }}
  validates :summary, { :length => { :maximum => 250 }}
  validates :category, inclusion: { in: ['Fiction', 'Non-Fiction']}
  # Couldn't figure below out
  validate :clickbait?
  # validates :title, exclusion: {within: %w(True Facts)}

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]

  def clickbait?
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end
end
