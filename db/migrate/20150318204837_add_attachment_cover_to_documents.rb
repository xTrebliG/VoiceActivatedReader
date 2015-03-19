class AddAttachmentCoverToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :documents, :cover
  end
end
