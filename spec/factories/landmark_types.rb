# == Schema Information
#
# Table name: landmark_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  factory :landmark_type do
    name "Landmark Type"
  end

end
