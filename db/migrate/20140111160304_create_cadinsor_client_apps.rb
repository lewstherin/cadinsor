class CreateCadinsorClientApps < ActiveRecord::Migration
  def change
    create_table :cadinsor_client_apps do |t|
      t.string :name
      t.string :secret
      t.timestamps
    end
  end
end
