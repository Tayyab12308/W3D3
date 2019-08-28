class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.integer 'user_id' 
      t.string 'long_url'
      t.string 'short_url' 
      t.timestamp 
    end
    add_index :shortened_urls, :short_url
  end
end
