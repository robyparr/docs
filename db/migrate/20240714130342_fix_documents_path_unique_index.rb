class FixDocumentsPathUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :documents, %i[organization_id path]
    remove_index :documents, :repository_id

    add_index :documents, %i[repository_id path], unique: true
  end
end
