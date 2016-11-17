class AddDmhEligibleToClients < ActiveRecord::Migration
  def change
    add_column :project_clients, :dmh_eligible, :boolean, null: false, default: false
    add_column :clients, :dmh_eligible, :boolean, null: false, default: false
  end
end
