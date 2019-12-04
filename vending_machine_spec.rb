require './vending_machine.rb'

describe VendingMachine do
  subject(:instance) { described_class.new(products_hash, coins_hash) }

  let(:products_hash) do
    {
      "food1" => { "name" => "mars", "price" => 2.5, "count" => 20 },
      "food2" => { "name" => "waffles", "price" => 1.5, "count" => 20 },
      "drink1" => { "name" => "water", "price" => 1, "count" => 10 },
      "non_food" => { "name" => "head phone", "price" => 20, "count" => 5 }
    }
  end


  let(:coins_hash) do
    {
      "0.01" => 10,
      "0.05" => 15,
      "0.1"  => 20,
      "0.25" => 20,
      "1.0"  => 30
    }
  end

  describe "#add_coin" do
    context "when adding coin is already present" do
      before { instance.add_coin("0.25", 10) }

      it "increases exist coin count" do
        expect(instance.coins_hash).to include({ "0.25" => 30 } )
      end
    end

    context "when adding coin that is not present in vending machine" do
      before { instance.add_coin("0.5", 4) }

      it "increases exist coin count" do
        expect(instance.coins_hash).to include({ "0.5" => 4 } )
      end
    end
  end

  describe "#introduce_product" do
    let(:product_key) { "food_3" }
    let(:name) { "Chips" }
    let(:price) { 2.3 }
    let(:count) { 8 }

    before { instance.introduce_product(product_key, name, price, count) }

    it "adds product to product list" do
      expect(instance.products_hash).to include({ product_key => { name: name, price: price, count: count } } )
    end
  end

  describe "#buy" do
    subject { instance.buy(product_key) }

    context "when product is present into machine" do
      let(:product_key) { "food1" }

      it "decreases count by 1 for this product" do
        expect { subject }.to change { instance.products_hash[product_key]["count"] }.by(-1)
      end
    end

    context "when product is absent into machine" do
      let(:product_key) { "unicorn" }

      it "increases exist coin count" do
        is_expected.to be_falsey
      end
    end
  end

  describe "#give_change" do
    subject { instance.give_change(amount) }

    context "when amount can be given with one nomination" do
      let(:amount) { 4.0 }

      it "decreases nomination" do
        expect { subject }.to change { instance.coins_hash["1.0"] }.by(-4)
      end
    end

    context "when amount can be given with a few nominations" do
      let(:amount) { 4.89 }

      it "decreases nominations" do
        expect {
          subject
        }.to change { instance.coins_hash["1.0"] }.by(-4)
        .and change { instance.coins_hash["0.25"] }.by(-3)
        .and change { instance.coins_hash["0.1"] }.by(-1)
        .and change { instance.coins_hash["0.01"] }.by(-4)
      end
    end
  end
end
