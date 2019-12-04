# Basic Vending Machine
### How to run tests:
```
rspec vending_machine_spec.rb
rspec vending_machine_process_spec.rb
```
## How to test manually(using console)
```
ruby console_app.rb


Example logs: 
Hello from Hero Vending Machine
Your balance: 0
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
1
Enter coin please
We accepted only: ["0.01", "0.05", "0.1", "0.25", "1.0"]
0.01
Your balance: 0.01
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
3
Your change: {0.01=>1}
Your balance: 0
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
1 
Enter coin please
We accepted only: ["0.01", "0.05", "0.1", "0.25", "1.0"]
0.01
Your balance: 0.01
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
3
impossible to give you change
Your balance: 0.01
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
1
Enter coin please
We accepted only: ["0.01", "0.05", "0.1", "0.25", "1.0"]
0.05
Your balance: 0.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
2
Press key of product you want to buy
food1 - mars $2.5
food2 - waffles $1.5
drink1 - water $1
non_food1 - head phone $20
food2
not_enough_money
Your balance: 0.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
1
Enter coin please
We accepted only: ["0.01", "0.05", "0.1", "0.25", "1.0"]
1.0
Your balance: 1.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
2
Press key of product you want to buy
food1 - mars $2.5
food2 - waffles $1.5
drink1 - water $1
non_food1 - head phone $20
drin! 
invalid product key
Your balance: 1.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
drink1
wrong command
Your balance: 1.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
2
Press key of product you want to buy
food1 - mars $2.5
food2 - waffles $1.5
drink1 - water $1
non_food1 - head phone $20
drink1
success
Your balance: 0.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
3
impossible to give you change
Your balance: 0.06
what are you going to do?
1. Enter money
2. Buy a good
3. Take a change
4. Quit
```