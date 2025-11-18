class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :domains
  validates :name, presence: {message: "Project name is missing"}
  validates :short_desc, presence: {message: "Short description is missing"}, length: {message: "Short description can be at most 40 characters", maximum: 40}
  validates :long_desc, presence: {message: "Long description is missing"}

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
