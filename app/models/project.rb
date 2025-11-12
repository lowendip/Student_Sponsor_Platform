class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :domains

  def self.belongs_to_student
    Project.joins(:user).where(user: {role: "Student"})
  end

  def self.belongs_to_sponsor
    Project.joins(:user).where(user: {role: "Sponsor"})
  end

  def self.active_projects
    Project.joins(:user).where(user: {status: "Active"})
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name","domains"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user","domains"]
  end
end
