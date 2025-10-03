class Project < ApplicationRecord
  belongs_to :user
   def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
