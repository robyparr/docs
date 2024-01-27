class AvatarComponent < ApplicationComponent
  erb_template <<-ERB
    <img src="<%= gravatar_url %>" class="rounded-full" />
  ERB

  def initialize(email:)
    @email = email
  end

  private

  def gravatar_url
    email_hash = Digest::SHA256.hexdigest @email.strip.downcase
    "https://gravatar.com/avatar/#{email_hash}?s=36"
  end
end
