# frozen_string_literal: true

# https://flowbite.com/docs/components/forms/
class InputComponent < ApplicationComponent
  erb_template <<-ERB
    <%= @form.public_send(@type, @name, @options.merge(class: classes)) %>
  ERB

  def initialize(form:, type:, name:, invalid: false, options: {})
    @form = form
    @type = type
    @name = name
    @invalid = invalid
    @options = options
  end

  private

  CHECKBOX_CLASSES = 'w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600'
  BASE_INPUT_CLASSES = 'bg-gray-50 border text-sm rounded-lg block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500'
  INPUT_STATE_CLASSES = {
    normal: 'border-gray-300 text-gray-900 focus:ring-blue-500 focus:border-blue-500',
    error: 'border-red-500 text-red-900 placeholder-red-700 focus:ring-red-500 dark:bg-gray-700 focus:border-red-500 dark:text-red-500 dark:placeholder-red-500 dark:border-red-500'
  }

  def check_box? = @type == :check_box
  def invalid? = @invalid == true

  def classes
    return CHECKBOX_CLASSES if check_box?

    if invalid?
      "#{BASE_INPUT_CLASSES} #{INPUT_STATE_CLASSES[:error]}"
    else
      "#{BASE_INPUT_CLASSES} #{INPUT_STATE_CLASSES[:normal]}"
    end
  end
end
