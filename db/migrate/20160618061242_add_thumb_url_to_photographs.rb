class AddThumbUrlToPhotographs < ActiveRecord::Migration
  def change
    add_column :photographs, :thumb_url, :string
  end
end
