    require 'net/http'
    require 'json'
    require 'active_support'
    require 'active_support/all'


=begin
      class InvoiceItem
          attr_accessor :name, :salePrice, :itemId, :availableOnline
      end


      class Invoice
          attr_accessor  :items

            def total
              @items.delete_if {|i| i.quantity == 0}
              invoice_total = @items.sum { |i| (i.quantity * i.price *) }
            end
       end
=end


    QUERY_URL = 'http://api.walmartlabs.com/v1/search'

    API_KEY = 'e54h6guhsu9kjct8mt8wry3a'

    puts "What product would you like to seach for?"
    product_search = $stdin.gets.strip

    url = URI(QUERY_URL + "?query=#{product_search}&format=json&apiKey=#{API_KEY}&sort=relevance")

    raw_json = Net::HTTP.get(url)

    search_results = JSON.parse(raw_json)
    items = search_results["items"]

    items.each do |item|
      puts "#{item["name"]}, #{item["salePrice"]}, #{item["itemId"]}, #{item["availableOnline"]}"
      #create Item object
      #call setter methods on Item object for each attribute
      #add the Item object to an array/collection of Item objects
    end
=begin
      i = Invoice.new
      i.items = []
     loop do

      invoice_item = InvoiceItem.new
      print "Please enter the product (press ENTER to quit): \n"
      invoice_item.product = gets
      break if invoice_item.product.strip == ""
      print "Please enter the sales price: \n"
      invoice_item.price = gets.to_f.round(2)
      print "Enter the quantity: \n"
      invoice_item.quantity = gets.to_i.round
      i.items << invoice_item
    end
=end
