class ChangeUrlColumnNameToSlugInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :url, :slug
  end
end
