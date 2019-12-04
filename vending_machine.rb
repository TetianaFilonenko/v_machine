class VendingMachine
  attr_reader :products_hash, :coins_hash

  def initialize(products_hash, coins_hash)
    @products_hash = products_hash
    @coins_hash = coins_hash
  end

  def add_coin(value, loading_count)
    loaded_count = coins_hash[value]
    coins_hash[value] = loaded_count ? loaded_count + loading_count : loading_count
  end

  def introduce_product(key, name, price, count)
    products_hash[key] = { "name" => name, "price" => price, "count" => count }
  end

  def buy(key)
    return false if products_hash.dig(key, "count").to_i == 0
    products_hash["food1"]["count"] -= 1
  end

  def give_change(amount)
    changes_hash = changes_hash(amount)
    return false unless changes_hash
    changes_hash.each_key do |change_key|
      coins_hash[change_key.to_s] -= changes_hash[change_key]
    end
    changes_hash.select {|_,v| v > 0 }
  end

  private

  def changes_hash(amount)
    change_result = {}
    return change_result if amount == 0
    sorted_nominations = nominations.sort.reverse


    for i in 0..(sorted_nominations.length - 1) do
      nomination = sorted_nominations[i]
      max_nomination_count = (amount / nomination).to_i
      possible_nomination_count = coins_hash[nomination.to_s]
      nomination_count =
        max_nomination_count > possible_nomination_count ? possible_nomination_count : max_nomination_count
      change_result[nomination] = nomination_count
      amount -= nomination_count * nomination
      amount = amount.round(2)
      break if amount == 0
    end

    return false if amount > 0

    change_result
  end

  def nominations
    coins_hash.keys.map(&:to_f)
  end
end
