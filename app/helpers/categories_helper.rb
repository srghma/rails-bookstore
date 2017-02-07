module CategoriesHelper
  def catalog_header_link_to(url, options)
    content_tag :li, class: 'mr-35' do
      title = options[:title]
      badge = content_tag(:span, options[:badge], class: 'badge general-badge')
      link_body = safe_join [title, badge]
      link_to link_body, url, class: 'filter-link'
    end
  end
end
