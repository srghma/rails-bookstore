module AllCategories
  extend ActiveSupport::Concern

  included do
    helper_method :all_categories
  end

  def all_categories
    @_all_categories ||= Category.all.pluck(:id, :name)
  end
end

