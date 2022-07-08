class RemoveAgentIdToContraventionNotebooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :contravention_notebooks, :agent_id
  end
end
