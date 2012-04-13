class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.string :question_and_answers
      t.string :answer
      t.string :email
      t.string :uuid

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
