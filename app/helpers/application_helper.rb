module ApplicationHelper
  # TODO
  # def current_url(overwrite = {})
  #   url_for only_path: false, params: params.merge(overwrite)
  # end

  def redirect_back_link(fallback_location:, **args)
    puts fallback_location, args
    link_to redirect_back({ fallback_location: fallback_location })
  end
end
