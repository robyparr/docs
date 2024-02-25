# frozen_string_literal: true

class Document::MarkdownRenderer
  include Singleton

  def render(content)
    renderer.render content
  end

  def render_table_of_contents(content)
    table_of_contents_renderer.render content
  end

  private

  MARKDOWN_OPTIONS = {
    tables: true,
    fenced_code_blocks: true,
    disable_indented_code_blocks: true,
    autolink: true,
    strikethrough: true,
    lax_spacing: true,
    space_after_headers: true,
    superscript: true,
    underline: true,
    highlight: true,
    footnotes: true
  }.freeze

  HTML_MARKDOWN_OPTIONS = {
    escape_html: true,
    safe_links_only: true,
    with_toc_data: true,
    link_attributes: { target: '_blank', rel: 'noopener' }
  }.freeze

  def renderer
    return @renderer if defined?(@renderer)

    html_renderer = Redcarpet::Render::HTML.new HTML_MARKDOWN_OPTIONS
    @renderer = Redcarpet::Markdown.new html_renderer, MARKDOWN_OPTIONS
  end

  def table_of_contents_renderer
    @table_of_contents_renderer ||= Redcarpet::Markdown.new Redcarpet::Render::HTML_TOC
  end
end
