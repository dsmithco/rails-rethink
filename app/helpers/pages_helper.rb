module PagesHelper

  def page_path(page)

    url = "/pages/#{page.slug}"

    if page.redirectable_url.present? && request.method == 'get'
      url = page.redirectable_url
    elsif page.page_id.present?
      url = "/pages/#{page.page.slug}/#{page.slug}"
    end

    return url
  end

end
