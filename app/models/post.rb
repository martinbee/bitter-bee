class Post < ActiveRecord::Base

  validates :content, presence: true, length: {maximum:140}

  validates :tag_list, length: {maximum: 40}

  belongs_to :user
  acts_as_taggable

  mount_uploader :photo, PhotoUploader
end
