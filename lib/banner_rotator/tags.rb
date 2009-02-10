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
  end
end