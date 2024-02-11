class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.references :organization, foreign_key: true
      t.string :path
      t.string :basename
      t.string :content
      t.references :parent, foreign_key: { to_table: :documents }
      t.timestamps
    end

    add_index :documents, %i[organization_id path], unique: true
  end
end
