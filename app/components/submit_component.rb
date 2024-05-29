# frozen_string_literal: true

# https://flowbite.com/docs/components/buttons/
class SubmitComponent < ButtonComponent
  erb_template <<-ERB
    <%= @form.submit content, class: classes %>
  ERB

  def initialize(form: nil, extra_classes: '')
    @form = form
    @extra_classes = extra_classes
  end
end
