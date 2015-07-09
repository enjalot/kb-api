# == Schema Information
#
# Table name: person_occupations
#
#  id            :integer          not null, primary key
#  occupation_id :integer
#  person_id     :integer
#

class PersonOccupation < ActiveRecord::Base
  belongs_to :occupation
  belongs_to :person
end
