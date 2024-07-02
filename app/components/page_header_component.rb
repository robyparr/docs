# frozen_string_literal: true

class PageHeaderComponent < ApplicationComponent
  erb_template <<-ERB
    <h2 class="text-2xl"><%= content %></h2>
    <div class="flex items-center space-x-2 mt-2">
      <% actions.each do |action| %>
        <%= action %>
      <% end %>
    </div>
  ERB

  renders_many :actions
end
