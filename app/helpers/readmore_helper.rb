module ReadmoreHelper
  def readmore(name, content, **options)
    data = {
      'data-readmore': true,
      'data-readmore-class': 'in-gold-500 ml-10',
      'data-readmore-moretext': 'Read More'
    }
    options.merge! data
    content_tag(name, content, options)
  end
end
