# frozen_string_literal: true

# https://flowbite.com/docs/customize/icons/#svg-icons
# SVG icons are from https://heroicons.com
class IconComponent < ApplicationComponent
  erb_template <<-ERB
    <%= image_tag icon_path, class: 'w-6 h-6 text-gray-800 dark:text-white' %>
  ERB

  def initialize(icon:)
    @icon = icon
  end

  private

  def icon_path
    "icons/#{@icon}.svg"
  end
end
