class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  	  t.string :user_name
	  t.string :first_name
	  t.string :second_name
	  t.string :tlf
	  t.text :content
	end
  end
end
