# frozen_string_literal: true

class PageHeaderComponent < ApplicationComponent
  erb_template <<-ERB
    <h2 class="text-2xl"><%= content %></h2>
  ERB
end
