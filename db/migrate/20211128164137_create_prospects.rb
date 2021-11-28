class CreateProspects < ActiveRecord::Migration[6.1]
  def change
    create_table :prospects do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :probability, default: 0
      t.references :company

      t.timestamps
    end
  end
end
