# frozen_string_literal: true

class Naver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  has_many :naver_projects
  has_many :projects, through: :naver_projects
  validates :name, :birthdate, :admission_date, :job_role, presence: true

  scope :by_name, -> (name) { where(name: name) }
  scope :by_job_role, -> (job_role) { where(job_role: job_role) }
  scope :by_ids, -> (naver_ids) { where(id: naver_ids) }
  scope :by_user, -> (user_id) { where(user_id: user_id) }
end
