# frozen_string_literal: true

module ArticlesHelper
  def mini_show(article)
    image_tag(article.image.url, class: 'object-cover w-12 h-12') if article.image.present?
  end

  def list_categories(data)
    cont = category_builder(data[0], true)
    data.shift
    data.each do |article|
      cont.concat(category_builder(article))
    end
    cont
  end

  def category_builder(article, aside = false)
    return unless article

    cls = 'relative'
    tag = 'section'
    if aside
      tag = 'aside'
      cls += ' row-span-2'
    end
    content_tag(tag, class: cls) do
      category_content(article)
    end
  end

  private

  def category_content(article, main = false)
    return unless article

    path = main ? root_path : article_path(article.category)
    link_to path, class: 'absolute h-full' do
      image_tag(article.image.present? ? article.image.url : 'missing.svg',
                opacity: 50,
                class: 'object-cover z-neg h-full w-full')
    end.concat(
      category_text_content(article, main)
    )
  end

  def category_text_content(article, main)
    justify = main ? 'justify-end' : 'justify-between'
    content_tag(:div, class: "flex flex-col p-4 h-full #{justify}") do
      content_tag(:h1, link_to(article.category.name, article_path(article.category.id)),
                  class: 'z-50 text-xl leading-5 mb-4 text-orange-1000')
        .concat(content_tag(:p, article.text[0..50], class: 'z-50 text-sm text-gray-200'))
    end
  end
end
