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

    path = main ? root_path : article_path(article.category_id)
    link_to path, class: 'absolute h-full' do
      image_tag(article.image.present? ? article.image.url : 'missing.svg',
                opacity: 50,
                class: 'object-cover z-neg h-full w-full')
    end.concat(
      category_text_content(article, main)
    )
  end

  def category_text_content(article, main)
    heading = main ? article.title : heading = article.name
    path = main ? root_path : article_path(article.category_id)
    justify = main ? 'justify-end' : 'justify-between'

    content_tag(:div, class: "flex flex-col p-4 h-full #{justify}") do
      content_tag(:h1, link_to(heading, path),
                  class: 'z-50 text-xl leading-5 mb-4 text-orange-1000')
        .concat(content_tag(:p, article.text[0..50], class: 'z-50 text-sm text-gray-200'))
    end
  end

  def list_articles(data)
    return unless data

    cont = article_builder(data[0])
    data.shift
    data.each do |a|
      cont.concat(article_builder(a))
    end
    cont
  end

  def article_builder(article)
    content_tag(:div,
                image_tag(article.image.present? ? article.image.url : 'missing.svg', class: 'object-cover w-full h-full my-2'),
                class: 'bg-gray-500')
      .concat(
        content_tag(:div, class: 'p-4') do
          content_tag(:h2, article.user.name.capitalize,
                      class: 'pb-1 mb-3 text-xl border-b-4 border-solid w-maxContent border-orange-1000
                              text-orange-1000')
              .concat(
                content_tag(:h1, article.title, class: 'mb-3 text-xl font-bold')
              ).concat(
                content_tag(:p, article.text[0..250], class: 'text-sm mb-4')
              ).concat(
                link_to('Vote', vote_path(article.id), method: :put, class: '
                bg-armadillo-500 hover:bg-armadillo-400 text-white font-bold py-2 mt-4 cursor-pointer
                px-4 border-b-4 border-armadillo-700 hover:border-armadillo-500 rounded')
              ).concat(
                link_to('Edit', edit_article_path(article), class: 'bg-armadillo-700 hover:bg-armadillo-600
                text-white font-bold py-2 mt-4 cursor-pointer mx-4
                px-4 border-b-4 border-armadillo-900 hover:border-armadillo-700 rounded')
              ).concat(
                link_to('Back', articles_path, class: 'mx-3 my-2 text-armadillo-500')
              )
        end
      )
  end
end
