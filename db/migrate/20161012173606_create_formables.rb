class CreateFormables < ActiveRecord::Migration[5.0]
  def change
    create_table :formables do |t|
      t.belongs_to :form, foreign_key: true
      t.references :formable, :polymorphic => true
      t.timestamps
    end
  end
end
