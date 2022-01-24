class AddAgentToContraventionNotebook < ActiveRecord::Migration[6.0]
  def change
    add_reference :contravention_notebooks, :agent, null: false, foreign_key: true
  end
end
