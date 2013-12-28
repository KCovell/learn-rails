class Transaction < ActiveRecord::Base
  has_no_table

  column :name, :string
  column :date, :date
  column :vendor, :string
  column :amount, :number

  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :vendor
  validates :amount, numericality: true
  
end