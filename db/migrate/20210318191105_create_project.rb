class CreateProject < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.belongs_to :user
      t.string :name
    end
  end
end
