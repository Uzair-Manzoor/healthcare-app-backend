class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.text :bio
      t.string :image_url
      t.string :specialization
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
