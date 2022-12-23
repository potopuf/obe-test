# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters, id: :uuid do |t|
      t.string :name, null: false
      t.string :species, null: false
      t.integer :episode, null: false, array: true
      t.timestamps
    end
    add_column :characters, :status, :character_statuses, null: false
    add_column :characters, :gender, :character_genders, null: false
  end
end
