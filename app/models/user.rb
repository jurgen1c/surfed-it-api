# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  username               :string
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Users::Allowlist
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :confirmable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :jwt_authenticatable,
          jwt_revocation_strategy: self

  has_many :allowlisted_jwts, dependent: :destroy

  has_one_attached :avatar

  #after_commit :add_default_avatar, on: %i[create update]

  def for_display
    {
      email: email,
      name: name,
      username: username,
      bio: bio,
      id: id,
    }
  end

  def avatar_thumbnail
    avatar.variant(resize: '150X150!').processed
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'profile.png'
        )
      ),
      filename: 'profile.png',
      content_type: 'image/png'
    )
  end
end
