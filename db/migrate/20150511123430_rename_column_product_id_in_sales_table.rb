class RenameColumnProductIdInSalesTable < ActiveRecord::Migration
  def change
  	rename_column :sales, :book_id, :product_id
  end
end
