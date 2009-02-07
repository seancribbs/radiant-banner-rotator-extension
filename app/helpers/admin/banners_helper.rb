module Admin::BannersHelper
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
