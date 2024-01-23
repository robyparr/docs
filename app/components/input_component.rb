# https://flowbite.com/docs/components/forms/
class InputComponent < ApplicationComponent
  erb_template <<-ERB
    <%= @form.public_send(@type, @name, @options.merge(class: classes)) %>
  ERB

  def initialize(form:, type:, name:, options: {})
    @form = form
    @type = type
    @name = name
    @options = options
  end

  private

  def check_box? = @type == :check_box

  def classes
    if check_box?
      'w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600'
    else
      'bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500'
    end
  end
end
