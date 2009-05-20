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
  
  def updated_stamp(model)
    unless model.new_record?
      updated_by = (model.updated_by || model.created_by) if model.respond_to?(:updated_by)
      login = updated_by ? updated_by.login : nil
      time = (model.updated_at || model.created_at)
      # promoted_at = model.draft_promoted_at if model.respond_to?(:draft_promoted_at)
      html = %{<p style="clear: left"><small>}
      if login or time
        html << 'Last updated ' 
        html << %{by #{login} } if login
        html << %{at #{ timestamp(time) }} if time
        html << '. '
      end
      # if promoted_at
      #   html << %{Last promoted at #{ timestamp(promoted_at) }.}
      # end
      html << %{</small></p>}
      html
    else
      %{<p class="clear">&nbsp;</p>}
    end
  end

end
