module BookPage
  class BookPresenter < Rectify::Presenter
    def initialize(book, quantity = nil, valid: true)
      @book = BookPage::BookDecorator.new(book, valid)
      @quantity = quantity || 1
    end

    attr_reader :book, :quantity

    def description
      readmore(:p, book.description, class: 'in-grey-600 small line-height-2')
    end

    def review_widget
      view_context.review_widget(
        description: book.description,
        image_url:   book.primary_cover,
        title:       book.title,
        id:          book.id,
        url:         book_url(book)
      )
    end

    def signed_data_widget
      return view_context.signed_data_widget(
        user_name:      nil,
        user_email:     nil,
        signature:      nil,
        time_stamp:     nil,
        reviewer_type:  nil
      ) unless user_signed_in?

      user_name = current_user.first_name
      user_email = current_user.email
      reviewer_type = 'verified_reviewer'
      time_stamp = Time.zone.now.to_i
      secret = Rails.application.secrets.secret_key_base
      signature = OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest::SHA256.new,
        secret,
        "#{user_email}#{reviewer_type}#{book.id}#{time_stamp}"
      )

      view_context.signed_data_widget(
        user_name:      user_name,
        user_email:     user_email,
        signature:      signature,
        time_stamp:     time_stamp,
        reviewer_type:  reviewer_type
      )
    end

    private

    def covers_urls
      @covers_urls = book.covers_urls
    end
  end
end
