class CreateCadinsorApiKeys < ActiveRecord::Migration
  def change
    create_table :cadinsor_api_keys do |t|
      t.string :value
      t.integer :client_app_id
      t.timestamps
    end
    add_index :api_keys, :value
  end
end
