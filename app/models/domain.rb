class Domain < ApplicationRecord
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :users
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end
end
