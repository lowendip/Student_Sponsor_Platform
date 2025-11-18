class User < ApplicationRecord
  has_secure_password
  before_create :confirmation_token
  has_and_belongs_to_many :domains
  has_many :projects, dependent: :delete_all
  validates :email, presence: {message: "Email is missing"}, uniqueness: {message: "Email already taken"}
  validates :username, presence: {message: "Username is missing"}, uniqueness: {message: "Username already taken"}
  validates :name, presence: {message: "Name is missing"}
  validates :contact, presence: {message: "Contact information is missing"}

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name","organization","role","username"]
  end


  def self.ransackable_associations(auth_object = nil)
    ["domains"]
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
