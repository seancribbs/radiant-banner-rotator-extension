module BannerRotator::Tags
  include Radiant::Taggable

  desc %{
    Selects a banner from the rotating banners available to this page. If
    no appropriate banner is found or they are disabled for this page,

    *Usage*:

    <pre><code><r:banner><!-- put some banner output code here --></r:banner></code></pre>
  }
  tag 'banner' do |tag|
    page = tag.locals.page
    tag.locals.banner = page.select_banner
    tag.expand if tag.locals.banner && page.show_banner?
  end

  %w{name background_image foreground_image link_url link_target image_style}.each do |att|
    desc %{
      Outputs the #{att} attribute of the current banner.

      *Usage*:

      <pre><code><r:banner><r:#{att} /></r:banner></code></pre>
    }
    tag "banner:#{att}" do |tag|
      tag.locals.banner.send(att)
    end
    desc %{
      Expands the contents if there is a non-empty #{att}.

      *Usage*:

      <pre><code>
      <r:banner>
        <r:if_#{att}>Content to display</r:if_#{att}>
      </r:banner>
      </code></pre>
    }
    tag "banner:if_#{att}" do |tag|
      tag.expand unless tag.locals.banner[att].blank?
    end
    desc %{
      Expands the contents if there is no #{att}.

      *Usage*:

      <pre><code>
      <r:banner>
        <r:unless_#{att}>Content to display</r:unless_#{att}>
      </r:banner>
      </code></pre>
    }
    tag "banner:unless_#{att}" do |tag|
      tag.expand if tag.locals.banner[att].blank?
    end
  end
end