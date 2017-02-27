class Project < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  belongs_to(:owner, class_name: 'User')
  has_many :rewards
  has_many :pledges, through: :rewards
  has_many :backers, through: :rewards
  has_many :comments
  accepts_nested_attributes_for :rewards, allow_destroy: true
  validates_presence_of :title, :description, :goal, :start_date, :end_date

end
