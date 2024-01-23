# https://flowbite.com/docs/components/forms/
class LabelComponent < ApplicationComponent
  erb_template <<-ERB
    <%= @form.label @name, class: "mb-2 text-sm font-medium text-gray-900 dark:text-white \#{extra_classes}" %>
  ERB

  def initialize(form:, name:, inline: false)
    @form = form
    @name = name
    @inline = inline
  end

  # private

  def inline? = @inline == true

  def extra_classes
    return nil if inline?

    'block'
  end
end
