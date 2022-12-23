# frozen_string_literal: true

class CreateCharacterStatuses < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE character_statuses AS ENUM ('Alive', 'Dead', 'unknown');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE character_statuses;
    SQL
  end
end
