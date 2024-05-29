# frozen_string_literal: true

# https://flowbite.com/docs/components/buttons/
class ButtonComponent < ApplicationComponent
  erb_template <<-ERB
    <% if @method %>
      <div class="inline-block">
        <%= button_to content, @href, class: classes, method: @method %>
      </div>
    <% elsif @href %>
      <%= link_to content, @href, class: classes %>
    <% else %>
      <button type="@type" class="<%= classes %>">
        <%= content %>
      </button>
    <% end %>
  ERB

  def initialize(type: 'button', href: nil, method: nil, extra_classes: '')
    @type = type
    @href = href
    @method = method
    @extra_classes = extra_classes
  end

  private

  def classes
    %(
      text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium
      rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700
      focus:outline-none dark:focus:ring-blue-800 #{@extra_classes}
    )
  end
end
