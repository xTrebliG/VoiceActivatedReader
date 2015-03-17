class AddFilePathToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :file_path, :string
  end
end
