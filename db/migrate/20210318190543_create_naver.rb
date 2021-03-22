class CreateNaver < ActiveRecord::Migration[6.1]
  def change
    create_table :navers do |t|
      t.belongs_to :user
      t.string :name
      t.date :birthdate
      t.date :admission_date
      t.string :job_role
    end
  end
end
