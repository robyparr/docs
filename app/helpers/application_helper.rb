module ApplicationHelper
  def component(name, options = {}, &block)
    klass = "#{name.camelcase}Component".constantize
    content = options.delete(:content)

    obj = klass.new(**options)
    obj = obj.with_content(content) if content

    render obj, &block
  end
end
