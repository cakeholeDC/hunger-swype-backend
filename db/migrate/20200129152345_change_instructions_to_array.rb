class ChangeInstructionsToArray < ActiveRecord::Migration[6.0]
  def change
	    add_column :recipes, :directions, :string, array: true, default: []
	end
end
