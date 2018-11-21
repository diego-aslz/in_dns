class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :record, foreign_key: true, null: false
      t.belongs_to :host, foreign_key: true, null: false

      t.timestamps
    end
  end
end
