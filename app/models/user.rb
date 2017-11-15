# frozen_string_literal: true

class User < ApplicationRecord
  include Users::FacebookAuth

  acts_as_paranoid
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable,
         omniauth_providers: [:facebook]

  has_many :engagements, as: :provider
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :projects

  enum role: %i[leader member ambassador]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :volunteer, inclusion: { in: [true, false] }

  def full_name
    "#{first_name} #{last_name}"
  end
end
