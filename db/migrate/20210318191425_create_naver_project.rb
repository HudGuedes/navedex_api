class CreateNaverProject < ActiveRecord::Migration[6.1]
  def change
    create_table :naver_projects, id: false do |t|
      t.belongs_to :naver
      t.belongs_to :project
    end
  end
end
