class AlterUsersAddOrganizationId < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, null: false
    remove_index :users, :email
    add_index :users, %i[organization_id email], unique: true
  end
end
