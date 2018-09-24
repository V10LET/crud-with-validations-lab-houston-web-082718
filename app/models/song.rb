class Song < ActiveRecord::Base
  # validates :title, presence: true
  # validates :released, inclusion: { in: %w(true false)}, allow_blank: true
  # validates :release_year, presence: true
  # validates :release_year, length: { maximum: Time.now.year }

  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'cannot be repeated by the same artist in the same year'
  }

  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Time.now.year
    }
  end

  def released?
    released
  end
end
