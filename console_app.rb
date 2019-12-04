require "./vending_machine.rb"
require "./vending_machine_process.rb"

products = {
    "food1" => { "name" => "mars", "price" => 2.5, "count" => 2 },
    "food2" => { "name" => "waffles", "price" => 1.5, "count" => 2 },
    "drink1" => { "name" => "water", "price" => 1, "count" => 1 },
    "non_food1" => { "name" => "head phone", "price" => 20, "count" => 5 }
}

coins = {
    "0.01" => 1,
    "0.05" => 5,
    "0.1"  => 5,
    "0.25" => 2,
    "1.0"  => 3
}

vending_machine = VendingMachine.new(products, coins)
vending_machine_process = VendingMachineProcess.new(vending_machine)
vending_machine_process.start_console