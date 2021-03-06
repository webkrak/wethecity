# frozen_string_literal: true

class SuperAdmin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
end
