class RenameColumnAddAttachmentPictureToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :picture, :profil_img
  end
end
