module ArticlesHelper
  def mini_show(article)
    image_tag(article.image.url, class: 'object-cover w-12 h-12') if article.image.present?
  end
end
