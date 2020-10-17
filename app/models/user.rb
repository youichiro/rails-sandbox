class User < ApplicationRecord
  has_secure_password

  has_many :tasks

  enum role: { general: 0, admin: 1 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  before_save :downcase_email
  before_destroy :least_one_admin

  def downcase_email
    self.email = email.downcase
  end

  private

  def least_one_admin
    if admin? && User.admin.size == 1
      throw :abort
    end
  end
end
