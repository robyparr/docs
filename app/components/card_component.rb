# https://flowbite.com/docs/components/card/
class CardComponent < ApplicationComponent
  erb_template <<-ERB
    <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
      <%= content %>
    </div>
  ERB
end
