module LayoutHelper

  # dirty hack to get rcov to see this
  def html_attrs(lang = 'en-US'); {:xmlns => "http://www.w3.org/1999/xhtml", 'xml:lang' => lang, :lang => lang}
  end

  def http_equiv_attrs
    {'http-equiv' => 'Content-Type', :content => 'text/html;charset=UTF-8'}
  end

  # allows for a default or custom page title
  # use: page_title('Artworks') # => ADMAC / Artworks
  def page_title
    title = @page_title ? "/ #{@page_title}" : ''
    content_tag(:title, 'GONDI.tv ' + title)
  end

  # allows specification of body class from view
  # use: page_style('two_column'), page_style('two_column green')
  def page_style(name)
    content_for(:page_style) { name }
  end

  # allows specification of view specific stylesheets
  # use: stylesheet('home')
  def stylesheet(*args)
    content_for(:stylesheets) { stylesheet_link_tag(*args) }
  end

  # allows specification of view specific javascripts
  # use: javascript('jquery.custom.plugin')
  def javascript(*args)
    args = *args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:javascripts) { javascript_include_tag()}
  end

  # outputs the corresponding flash message if set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), :class => "#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
end