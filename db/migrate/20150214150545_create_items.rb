class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :audio_clip

      t.timestamps null: false
    end
  end
end
