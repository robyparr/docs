# https://flowbite.com/docs/components/alerts/
class FlashComponent < ApplicationComponent
  erb_template <<-ERB
    <div class="min-w-[50%] p-4 mb-4 text-sm rounded-lg <%= type_classes %>" role="alert">
      <%= content %>
    </div>
  ERB

  def initialize(type: :notice)
    @type = type
  end

  def render?
    content.present?
  end

  private

  def alert? = @type == :alert

  def type_classes
    if alert?
      'text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400'
    else
      'text-blue-800 bg-blue-50 dark:bg-gray-800 dark:text-blue-400'
    end
  end
end
