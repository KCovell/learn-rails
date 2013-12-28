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
  
  def update_spreadsheet
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
    ss = connection.spreadsheet_by_title('Learn-Rails-Example')
    if ss.nil?
      ss = connection.create_spreadsheet('Learn-Rails-Example')
    end
    ws = ss.worksheets[1]
    last_row = 1 + ws.num_rows
    ws[last_row, 1] = Time.new
    ws[last_row, 2] = self.name
    ws[last_row, 3] = self.date
    ws[last_row, 4] = self.vendor
    ws[last_row, 5] = self.amount
    ws.save
  end

end
end