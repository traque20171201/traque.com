class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :code,               null: false, default: ""
      t.string :name,               null: false, default: ""
      t.bigint :registrationVolume, null: true, default: 0
      t.bigint :outstandingVolume,  null: true, default: 0
      t.string :website,            null: true, default: ""
      t.string :industry,           null: true, default: ""

      t.timestamps
    end
  end
end
