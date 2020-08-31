require 'csv'
desc "Remove and reseed models for CSV data"
task :import => [:environment] do

  models = [Transaction, InvoiceItem, Invoice, Item, Merchant, Customer]

  models.each do |model|
    model.destroy_all
    puts "#{model} objects destroyed!"
  end

  models.reverse.each do |model|
    puts "#{model} objects coming in hot!"
    CSV.foreach("./data/#{model}s.csv",
                  headers: true, header_converters: :symbol) do |row|
                    model.create!(row.to_h)
                  end
  end
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence! (t)
  end

  puts "and scene...ready to rails engine it up."
end
