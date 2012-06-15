class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip
      t.text :notes

      t.timestamps
    end
  end
end
