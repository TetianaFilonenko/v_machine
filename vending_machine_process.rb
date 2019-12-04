class VendingMachineProcess
  attr_reader :vending_machine
  attr_accessor :entered_amount

  def initialize(vending_machine, entered_amount = 0)
    @vending_machine = vending_machine
    @entered_amount = entered_amount
  end

  def available_products
    vending_machine.products_hash
  end

  def keys
    available_products.keys
  end

  def add_coin(coin)
    self.entered_amount += coin
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
    self.entered_amount = 0
    result_hash || :failed
  end

  private

  def validate_product(product)
    return :not_possible unless product
    return :out_of_stock if product["count"] == 0
    return :not_enough_money if product["price"] > entered_amount
    :valid
  end
end

