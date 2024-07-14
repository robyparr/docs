class AddPublicFieldsToRepositories < ActiveRecord::Migration[7.1]
  def change
    add_column :repositories, :public, :boolean, null: false, default: false
    add_column :repositories, :public_slug, :string
  end
end
