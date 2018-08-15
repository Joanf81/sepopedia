class CreateArticleEdition < ActiveRecord::Migration[5.2]
  def change
    create_table :article_editions do |t|
    	t.text :content
    	t.string :picture

    	t.belongs_to :article, index: true
    	t.belongs_to :user, index: true

    	t.timestamps
    end
  end
end
