# https://flowbite.com/docs/components/card/
class CardComponent < ApplicationComponent
  erb_template <<-ERB
    <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-slate-800 dark:border-slate-700">
      <%= content %>
    </div>
  ERB
end
