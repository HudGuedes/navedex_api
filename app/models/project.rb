# frozen_string_literal: true

class Project < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  has_many :naver_projects
  has_many :navers, through: :naver_projects
  validates :name, presence: true

  scope :by_projects_id, -> (project_ids) { where(id: project_ids) }
  scope :by_user, -> (user_id) { where(user_id: user_id) }
end
