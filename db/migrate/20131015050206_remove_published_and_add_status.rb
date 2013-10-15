class RemovePublishedAndAddStatus < ActiveRecord::Migration
  def change
    add_column :articles, :status, :string, default: 'draft'

    # migrate published field to the new status field
    reversible do |dir|
      dir.up do
        Article.find_each(batch_size: 1000) do |article|
          article.status = article.published ? 'published' : 'draft'
          article.save
        end
      end

      dir.down do
        Article.find_each(batch_size: 1000) do |article|
          case article.status
          when 'published'
            article.published = true
          when 'draft'
            article.published = false
          end
          article.save
        end
      end
    end

    remove_column :articles, :published, :boolean
  end
end
