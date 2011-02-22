class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.string :title
      t.integer :solved_by, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
