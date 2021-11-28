class AddStageToProspects < ActiveRecord::Migration[6.1]
  def change
    add_column :prospects, :stage, :string, default: "lead"
  end
end
