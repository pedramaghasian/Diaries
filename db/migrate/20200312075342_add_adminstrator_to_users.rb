class AddAdminstratorToUsers < ActiveRecord::Migration[6.0]
  def change

    add_column :users,:adminstrator,:boolean , default: false
  end
end
