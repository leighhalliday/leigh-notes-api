class AuthToken < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  belongs_to :user

  # == Validations ==========================================================

  validates :token, presence: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  def self.generate!(user)
    self.create!({
      user: user,
      token: SecureRandom.uuid
    })
  end

  def self.find_user(token)
    auth_token = self.includes(:user).find_by(token: token)
    return nil if auth_token.blank?
    auth_token.user
  end

  # == Instance Methods =====================================================
end
