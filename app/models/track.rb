# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  album_id     :integer          not null
#  feature_type :string           not null
#  lyrics       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Track < ActiveRecord::Base
  FEATURE_TYPES = ["Bonus", "Regular"]

  validates :name, :album_id, :feature_type, presence: true
  validates :feature_type, inclusion: FEATURE_TYPES

  belongs_to :album
  has_many :notes, dependent: :destroy

end
