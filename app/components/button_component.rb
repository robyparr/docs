class ButtonComponent < ApplicationComponent
  erb_template <<-ERB
    <% if submit? %>
      <%= @form.submit content, class: classes %>
    <% end %>
  ERB

  def initialize(type: 'button', form: nil, extra_classes: '')
    @type = type
    @form = form
    @extra_classes = extra_classes
  end

  private

  def submit? = @type == 'submit'

  def classes
    'text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800 ' + @extra_classes
  end
end
