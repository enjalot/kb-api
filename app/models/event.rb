# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legacy_id     :integer
#  event_type_id :integer
#  year          :integer
#  date          :date
#  lonlat        :geometry({:srid= point, 0
#  description   :text
#

class Event < ActiveRecord::Base

  has_many :person_events
  has_many :people, :through => :person_events
  belongs_to :event_type

  validates :legacy_id, uniqueness: true

  #
  # Match events that occur after a given year.
  #
  # @param year [Integer]
  #
  def self.after_year(year)
    where("(year > ? AND date IS NULL) OR (date > ? AND year IS NULL)", year, Date.new(year))
  end

  #
  # Match events that occur before a given year.
  #
  # @param year [Integer]
  #
  def self.before_year(year)
    where("(year < ? AND date IS NULL) OR (date < ? AND year IS NULL)", year, Date.new(year))
  end

  #
  # Match events inside of an arbitrary polygon.
  #
  # @param extent [String]
  #
  def self.in_extent(extent)
    # TODO
  end

  #
  # Match events within a radius around a point.
  #
  # @param lon [Float]
  # @param lat [Float]
  # @param radius [Float]
  #
  def self.in_radius(lonlat, radius)
    # TODO
  end

  #
  # Match events linked to people with a given occupation.
  #
  # @param occupation_id [Integer]
  #
  def self.by_occupation(occupation_id)
    # TODO
  end

  #
  # Match events of a given type.
  #
  # @param type_id [Integer]
  #
  def self.by_type(type_id)
    # TODO
  end

end
