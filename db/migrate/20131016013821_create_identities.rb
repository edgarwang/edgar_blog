class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :provider
      t.references :user

      t.timestamps
    end
  end
end
