# frozen_string_literal: true

# https://flowbite.com/docs/components/forms/#form-validation
class InputErrorComponent < ApplicationComponent
  erb_template <<-ERB
    <% @errors.each do |error| %>
      <p class="mt-2 text-sm text-red-600 dark:text-red-500">
        <%= error.capitalize %>
      </p>
    <% end %>
  ERB

  def initialize(errors: [])
    @errors = errors
  end
end
