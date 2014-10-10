          require 'net/http'
          require 'json'
          require 'active_support'
          require 'active_support/all'


            class InvoiceItem
                  attr_accessor :name, :salePrice, :itemId, :availableOnline
            end


            class Invoice
                  attr_accessor  :items

                  def total
                    @items.delete_if {|i| i.quantity == 0}
                    invoice_total = @items.sum { |i| (i.quantity * i.price) }
                  end
           end





          QUERY_URL = 'http://api.walmartlabs.com/v1/search'

          API_KEY = 'e54h6guhsu9kjct8mt8wry3a'


          loop do

              print "What item would you like to seach for? (press enter to quit)\n"
              product_search = $stdin.gets.strip

              break if product_search.strip == ""


               url = URI(QUERY_URL + "?query=#{URI.escape(product_search)}&format=json&apiKey=#{API_KEY}&sort=relevance")

              raw_json = Net::HTTP.get(url)

              search_results = JSON.parse(raw_json)
              items = search_results["items"]

              items.each do |item|
                 puts "#{item["name"]}, #{item["salePrice"]}, #{item["itemId"]}, #{item["availableOnline"]}"
              end

              i = Invoice.new
              i.items = []

              print "To narrow your search, enter the Item Id: \n"
              item_id = gets.chomp.strip.to_i
              user_input_id = items.select { |x| x["itemId"] == item_id.to_i}.first


              invoice_item = InvoiceItem.new

              invoice_item.name = user_input_id["name"]
              puts "The item is #{invoice_item.name}\n"
              invoice_item.salePrice = user_input_id["salePrice"]
              puts "The sales price is #{invoice_item.salePrice}: \n"
              invoice_item.salePrice = gets.to_f.round(2)
              i.items << invoice_item


          end
