class AddRegionToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :region, :string, default: nil
  end
end
