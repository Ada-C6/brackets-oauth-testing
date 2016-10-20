class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :user, null: false, index: true
      t.string :title, null: false
      t.text :content

      t.timestamps null: false
    end
  end
end
