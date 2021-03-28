# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string
#  difficulty :string
#  condition  :text
#  direction  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Location < ApplicationRecord
  belongs_to :user
  has_many :surf_sessions, dependent: :destroy

  has_one_attached :cover

  after_commit :add_default_cover, on: %i[create update]

  def cover_thumbnail
    cover.variant(resize: '650X300!').processed
  end

  private

  def add_default_cover
    return if cover.attached?

    cover.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'wave.png'
        )
      ),
      filename: 'wave.png',
      content_type: 'image/png'
    )
  end
end
