class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :domains

  def self.ransackable_attributes(auth_object = nil)
    ["name","domains"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["domains"]
  end
end
