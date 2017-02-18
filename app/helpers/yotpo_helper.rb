module YotpoHelper
  def review_widget(**options)
    data = {
      'description': options[:description],
      'image-url':   options[:image_url],
      'name':        options[:title],
      'product-id':  options[:id],
      'url':         options[:url]
    }
    content_tag :div, nil, class: 'yotpo yotpo-main-widget', data: data
  end
end
