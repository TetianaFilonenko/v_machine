require './vending_machine.rb'
require './vending_machine_process.rb'

describe VendingMachineProcess do
  subject(:instance) { described_class.new(vending_machine) }

  let(:products_hash) do
    {
        "food1" => { "name" => "mars", "price" => 2.5, "count" => 20 },
        "food2" => { "name" => "waffles", "price" => 1.5, "count" => 20 },
        "drink1" => { "name" => "water", "price" => 1, "count" => 10 },
        "non_food1" => { "name" => "head phone", "price" => 20, "count" => 5 }
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

  let(:vending_machine) { VendingMachine.new(products_hash, coins_hash) }

  describe "#available_products" do
    subject { instance.available_products }

    it { is_expected.to eq(products_hash) }
  end

  describe "#keys" do
    subject { instance.keys }

    it { is_expected.to eq(["food1", "food2", "drink1", "non_food1"]) }
  end

  describe "#add_coin" do
    let(:amount) { 1.0 }

    subject { instance.add_coin(amount) }

    it "increases entered_amount" do
      expect { subject }.to change { instance.entered_amount }.by(amount)
    end
  end

  describe "#subtract_coin" do
    let(:amount) { 1.0 }

    subject { instance.subtract_coin(amount) }

    it "decreases entered_amount" do
      expect { subject }.to change { instance.entered_amount }.by(-amount)
    end
  end

  describe "#buy_product" do
    subject { instance.buy_product(product_key) }

    context "when product key is wrong" do
      let(:product_key) { "unicorn" }


      it { is_expected.to eq(:not_possible) }
    end

    context "when product is out of stock" do
      let(:product_key) { "food1" }

      before { vending_machine.products_hash[product_key]["count"] = 0 }

      it { is_expected.to eq(:out_of_stock) }
    end

    context "when user doen't have enough money" do
      let(:product_key) { "food1" }

      before do
        instance.add_coin(1.0)
        instance.add_coin(1.0)
        instance.add_coin(0.25)
      end

      it { is_expected.to eq(:not_enough_money) }
    end

    context "when user has enough money" do
      let(:product_key) { "food1" }

      before do
        instance.add_coin(1.0)
        instance.add_coin(1.0)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
      end

      it "responds with success status" do
        is_expected.to eq(:success)
      end

      it "decreases entered amount of money" do
        expect { subject }.to change { instance.entered_amount }.by(-2.5)
      end

      it "desreases products count for vendoring machine" do
        expect { subject }.to change { instance.available_products[product_key]["count"] }.by(-1)
      end
    end
  end

  describe "#finish" do

    subject { instance.finish }

    context "when vending machine has enough money to give change" do
      before do
        instance.add_coin(1.0)
        instance.add_coin(1.0)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
      end

      it "returns hash of nominations and their count" do
        is_expected.to eq({ 1.0 => 3, 0.25 => 2})
      end

      it "decreases nominations of each coin which is given to user" do
        expect {
          subject
        }.to change { instance.vending_machine.coins_hash["1.0"] }.by(-3)
        .and change { instance.vending_machine.coins_hash["0.25"] }.by(-2)
      end

      it "resets entered amount" do
        expect { subject }.to change { instance.entered_amount }.to(0)
      end
    end

    context "when vending machine does not enough money to give change" do
      let(:coins_hash) do
        {
          "0.25" => 1,
          "1.0"  => 3
        }
      end

      before do
        instance.add_coin(1.0)
        instance.add_coin(1.0)
        instance.add_coin(0.25)
        instance.add_coin(0.25)
      end

      it "returns failed" do
        is_expected.to eq(:failed)
      end
    end
  end

end
