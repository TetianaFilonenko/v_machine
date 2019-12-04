require "pry"
class VendingMachineProcess
  attr_reader :vending_machine
  attr_accessor :entered_amount

  def initialize(vending_machine, entered_amount = 0)
    @vending_machine = vending_machine
    @entered_amount = entered_amount
  end

  def entered_amount
    @entered_amount.round(2)
  end

  def available_products
    vending_machine.products_hash
  end

  def coins
    vending_machine.coins_hash
  end

  def keys
    available_products.keys
  end

  def add_coin(coin)
    self.entered_amount += coin.to_f
  end

  def subtract_coin(coin)
    self.entered_amount -= coin
  end

  def buy_product(key)
    product = available_products[key]
    validation = validate_product(product)
    return validation unless validation == :valid
    vending_machine.buy(key)
    subtract_coin(product["price"])
    :success
  end

  def finish
    result_hash = vending_machine.give_change(entered_amount)
    self.entered_amount = 0 if result_hash
    result_hash || :failed
  end

  def start_console
    puts "Hello from Hero Vending Machine"
    run_console = true
    while run_console
      puts "Your balance: #{self.entered_amount}"
      puts "what are you going to do?"
      puts "1. Enter money"
      puts "2. Buy a good"
      puts "3. Take a change"
      puts "4. Quit"

      command = gets.chomp
      case command
      when "1"
        enter_money
      when "2"
        press_buy
      when "3"
        press_take_change
      when "4"
        run_console = false
      else
        puts "wrong command"
      end
    end
  end

  private

  def enter_money
    puts "Enter coin please"
    puts "We accepted only: #{coins.keys}"
    coin = gets.chomp
    if coins.keys.include?(coin)
      add_coin(coin)
    else
      puts "invalid coin"
    end
  end

  def press_buy
    puts "Press key of product you want to buy"
    puts available_products.map{|key, product| "#{key} - #{product["name"]} $#{product["price"]}" }
    product = gets.chomp
    if available_products.keys.include?(product)
      puts buy_product(product)
    else
      puts "invalid product key"
    end
  end

  def press_take_change
    result = finish
    puts (result == :failed ? "impossible to give you change" : "Your change: #{result}")
  end

  def validate_product(product)
    return :not_possible unless product
    return :out_of_stock if product["count"] == 0
    return :not_enough_money if product["price"] > entered_amount
    :valid
  end
end
