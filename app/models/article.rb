class Article < ApplicationRecord
  has_attached_file :image,
                    storage: :cloudinary, path: 'uploaded/:class/:attachment/:id/:style_:filename'
  validates_attachment_content_type :image, content_type: %w[image/jpeg image/gif image/png]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes
  validates_presence_of :title
  validates_presence_of :text
end
