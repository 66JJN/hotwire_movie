# Books (and Active Storage, used only for book covers) are not part of the Movies app.
class DropBooksAndActiveStorage < ActiveRecord::Migration[8.1]
  def up
    drop_table :active_storage_variant_records
    drop_table :active_storage_attachments
    drop_table :active_storage_blobs
    drop_table :books
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Restore Books from git history (commit c160738) if needed"
  end
end
