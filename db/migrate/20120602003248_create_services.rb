class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :service_check
      t.text :notes
      t.references :host

      t.timestamps
    end
    add_index :services, :host_id
  end
end
