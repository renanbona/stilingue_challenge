class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :first_word_id
      t.integer :second_word_id

      t.timestamps
    end
    add_index :relationships, :first_word_id
    add_index :relationships, :second_word_id
  end
end
