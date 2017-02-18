class BooksDecorator < SimpleDelegator
  delegate :current_page, :total_pages, :limit_value, :entry_name,
           :total_count, :offset_value, :last_page?, :next_page,
           to: :undecorated

  def initialize(target, decorator_class)
    decorated = target.map { |object| decorator_class.new(object) }
    super(decorated)
    @undecorated = target
  end

  attr_reader :undecorated
end

