module CategoryPage
  class BooksDecorator < SimpleDelegator
    def initialize(target)
      decorated = target.map { |object| CategoryPage::BookDecorator.new(object) }
      super(decorated)
      @undecorated = target
    end

    attr_reader :undecorated

    delegate :current_page, :total_pages, :limit_value, :entry_name,
             :total_count, :offset_value, :last_page?, :next_page,
             to: :undecorated
  end
end
