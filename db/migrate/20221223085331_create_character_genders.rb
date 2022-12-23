# frozen_string_literal: true

class CreateCharacterGenders < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE character_genders AS ENUM ('Female', 'Male', 'Genderless', 'unknown');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE character_genders;
    SQL
  end
end
