class CreateApiTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :api_tokens do |t|
      t.references :repository, null: false, foreign_key: { on_delete: :cascade }
      t.string :token, null: false, index: { unique: true }
      t.string :name, null: false
      t.datetime :last_used_at
      t.integer :usage_count, null: false, default: 0

      t.timestamps
    end
  end
end
