# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  recording_type :string           not null
#  band_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Album < ActiveRecord::Base
  RECORDING_TYPE = ["Live", "Studio"]

  validates :name, :recording_type, :band_id, presence: true
  validates :recording_type, inclusion: RECORDING_TYPE

  has_many :tracks, dependent: :destroy
  belongs_to :band
end
