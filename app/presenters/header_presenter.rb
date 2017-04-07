class HeaderPresenter < Rectify::Presenter
  def categories
    @categories ||= Category.all
  end
end
