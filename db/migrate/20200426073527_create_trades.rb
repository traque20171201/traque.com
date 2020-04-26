class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.date :tradingDate,    null: false, default: ""
      t.integer :tradingType, null: false, default: 1
      t.bigint :volume,       null: false, default: 0
      t.integer :price,       null: false, default: 0
      t.bigint :money,        null: true, default: 0
      t.integer :fee,         null: true, default: 0
      t.integer :tax,         null: true, default: 0
      t.references :user,     null: false, foreign_key: true
      t.references :stock,    null: false, foreign_key: true

      t.timestamps
    end
  end
end
