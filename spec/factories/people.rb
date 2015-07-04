# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  family_name :string
#  given_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sex         :string
#  birth_year  :integer
#  death_year  :integer
#  legacy_id   :string
#


FactoryGirl.define do
  factory :person do
    family_name   "William"
    given_name    "Shakespeare"
  end
end