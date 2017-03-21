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

  def signed_data_widget(**options)
    data = {
      'user-name':      options[:user_name],
      'user-email':     options[:user_email],
      'signature':      options[:signature],
      'time-stamp':     options[:time_stamp],
      'reviewer-type':  options[:reviewer_type],
      'reviewer-badge': options[:reviewer_badge]
    }
    content_tag :div, nil, class: 'yotpo-signed-data', data: data
  end
end
