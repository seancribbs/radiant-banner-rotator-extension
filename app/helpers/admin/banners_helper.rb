module Admin::BannersHelper

  def link_or_span_unless_current(params, text, url, options)
    if options[:id] == params[:view]
      content_tag(:span, text)
    else
      link_to text, url, options
    end
  end

  def pages_for_select
    @pages_for_select ||= begin
      collect_children = lambda do |page|
        [page] + (page.children.any? ? page.children.map(&collect_children) : [])
      end
      collect_children[Page.find_by_parent_id(nil)].flatten.uniq.map do |page|
        name = page.parent ? "#{'--' * page.ancestors.size} #{page.title}" : page.title
        [name, page.id]
      end
    end
  end
end
