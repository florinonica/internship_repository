class AddTypeToTickets < ActiveRecord::Migration[5.2]
  def change
  	add_column :tickets, :type, :string
  end
end
