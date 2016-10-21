module PagesHelper
  def conditional_page_link(page, **kwargs)
    if !page.id.nil?
      link_to "Return to Page", page, **kwargs
    end
  end
end
