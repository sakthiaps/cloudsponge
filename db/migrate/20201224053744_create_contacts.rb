class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :street
      t.string :city
      t.string :region
      t.string :country
      t.string :postal_code
      t.string :company
      t.string :source
      t.string :job_title
      t.string :dob
      t.string :full_address


      t.timestamps
    end
  end
end
