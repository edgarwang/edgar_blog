require 'rouge/plugins/redcarpet'

class HTMLRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def block_code(code, language)
    begin
      Rouge.highlight(code, language, 'html') 
    rescue RuntimeError
      Rouge.highlight(code, 'text', 'html') 
    end
  end
end

def render_markdown(text)
  render_options = {
    filter_html:     true,
    hard_wrap:       true, 
    link_attributes: { rel: 'nofollow' }
  }
  renderer = HTMLRender.new(render_options)

  extensions = {
    autolink:           true,
    fenced_code_blocks: true,
    lax_spacing:        true,
    no_intra_emphasis:  true,
    strikethrough:      true,
    superscript:        true
  }
  Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
end
