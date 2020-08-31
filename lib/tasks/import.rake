require 'csv'
desc "Remove and reseed models for CSV data"
task :import => [:environment] do

  models = [Transaction, InvoiceItem, Invoice, Item, Merchant, Customer]

  models.each do |model|
    model.destroy_all
    puts "#{model} objects destroyed!"
  end

  models.reverse.each do |model|
    CSV.foreach("./data/#{model}s.csv",
                  headers: true, header_converters: :symbol) do |row|
                    model.create!(row.to_h)
                    new = model.last
                    if new[:unit_price]!= nil
                      new[:unit_price] = new[:unit_price]/100
                      new.save
                    end
                  end
    total = model.all.count
    puts "#{total} #{model} objects coming in hot!"
  end

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence! (t)
  end

  puts "And scene...ready to Rails Engine it up..."
end
