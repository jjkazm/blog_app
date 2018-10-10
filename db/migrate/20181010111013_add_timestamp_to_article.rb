class AddTimestampToArticle < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :articles, default: DateTime.now
  end
end
