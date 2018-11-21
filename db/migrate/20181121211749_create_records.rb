class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.inet :ip, null: false

      t.timestamps
    end

    add_index :records, :ip, unique: true
  end
end
