class Article < ApplicationRecord
  has_attached_file :image,
                    storage: :cloudinary, path: 'uploaded/:class/:attachment/:id/:style_:filename'
  validates_attachment_content_type :image, content_type: %w[image/jpeg image/gif image/png]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  belongs_to :user
  belongs_to :category
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :text, presence: true

  scope :featured, lambda {
    Article.joins(:votes, :category).select('articles.*, count(article_id) AS count_all')
      .group('article_id, title, text, articles.id')
      .order(count_all: :desc).limit(1)
  }

  scope :articles, lambda { |id, u_id|
    Article.joins(:category, :user)
      .select("users.*,
               articles.*,
               title,
               user_id,
               text,
               (select count(av)
                from votes av
                where av.article_id = articles.id
                  and av.user_id = #{u_id}
               ) as voted,
               (select count(av)
                from votes av
                where av.article_id = articles.id
               ) as total_votes")
      .where(categories: { id: id }).order(:updated_at).to_a
  }

  scope :cat_list, lambda {
    Article.joins('join(SELECT
                            category_id,
                            name,
                            priority,
                            (select articles.id from articles where category_id = categories.id
                              order by updated_at desc limit 1) as art_id
                        FROM categories
                                 INNER JOIN articles ON articles.category_id = categories.id
                        GROUP BY categories.id, "categories"."name", category_id
                        ORDER BY max(categories.priority) desc)
                    c on c.art_id = articles.id
    ').select('*').to_a
  }
end
