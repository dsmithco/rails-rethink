module PagesHelper
  def page_path(page)
    if page.page_id.present?
      "/pages/#{page.page.slug}/#{page.slug}"
    else
      "/pages/#{page.slug}"
    end
  end
end
