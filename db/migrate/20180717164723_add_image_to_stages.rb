class AddImageToStages < ActiveRecord::Migration[5.2]
  def change
    add_column :stages, :image, :string
  end
end
