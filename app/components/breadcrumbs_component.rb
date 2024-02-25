# frozen_string_literal: true

# https://flowbite.com/docs/components/breadcrumb/
class BreadcrumbsComponent < ApplicationComponent
  erb_template <<~ERB
      <nav class="flex <%= @classes %>" aria-label="Breadcrumb">
        <ol class="inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse">
          <% each_path_segment do |segment, is_first, is_last| %>
            <% if !is_first %>
              <svg class="rtl:rotate-180 w-3 h-3 text-gray-400 mx-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"/>
              </svg>
            <% end %>

            <li class="inline-flex items-center" <%= is_last ? 'aria-current="page"' : '' %>>
              <% if is_first %>
                <%= link_to segment, root_path, class: 'inline-flex items-center text-sm font-medium text-gray-700 dark:text-gray-400' %>
              <% elsif is_last %>
                <span class="ms-1 text-sm font-medium text-gray-500 md:ms-2 dark:text-gray-400"><%= segment %></span>
              <% else %>
                <span class="inline-flex items-center text-sm font-medium text-gray-700 dark:text-gray-400">
                  <%= segment %>
                </span>
              <% end %>
            </li>
          <% end %>
        </ol>
    </nav>
  ERB

  def initialize(path:, classes:)
    @path = path
    @classes = classes
  end

  private

  def path_segments
    @path_segments ||= @path.split('/')
  end

  def each_path_segment
    path_segments = @path.split '/'
    length = path_segments.length

    path_segments.each.with_index do |segment, index|
      is_first = index.zero?
      is_last = index == length - 1

      yield segment, is_first, is_last
    end
  end
end
