require 'io/console'

def withdrawl
  withdraw = true

  while withdraw do
      print "How much would you like to withdraw? "
      amount = gets.to_i
      puts
      if amount%100 != 0
        puts "Please enter amount in multiples of 100"
        puts
      elsif amount > $balance
        puts "Insufficient balance."
        puts
        withdraw = false
      elsif amount == 0
        puts "Please enter amount greater than 0"
        puts
      else
        $balance = $balance - amount
        puts "Please collect your cash."
        puts
        t = Time.now()
        time = t.strftime("%d/%m/%Y %H:%M")

        file = File.open("atm.txt", "a")
        file.puts("Withdrawl of $#{$balance} at #{time}")

        withdraw = false
      end

    end
end


def deposit
  print "How much would you like to deposit? "
  amount = gets.to_i
  puts
  $balance = $balance + amount
  # puts "balance : #{$balance}"
  t = Time.now()
  time = t.strftime("%d/%m/%Y %H:%M")

  file = File.open("atm.txt", "a")
  file.puts("Deposit of $#{$balance} at #{time}")
end


def check_balance
  puts "Your account balance is $#{$balance}. "
  puts
end


def account_statement
  puts "Here is the summary of your last few transactions : "
  puts "****************************************************"
  File.foreach( 'atm.txt' ) do |line|
    puts line
    puts
  end
  puts "****************************************************"
  puts
end



def main
  puts "***********************************************************************"
  puts "                Welcome to the Bank of Australia                       "
  puts "***********************************************************************"
  puts
  language_valid = true
  while language_valid do
    puts "What is your preferred language! : "
    puts
    puts "1. English"
    puts "2. French"
    puts "3. Spanish"
    puts "4. Hindi"
    puts
    print "Please enter your choice (1, 2, 3 or 4) : "
    language = gets.to_i
    puts
    if (1..4).include?(language)
      language_valid = false
    else
      puts "Invalid choice. Please enter correct choice!"
      puts
    end
  end

  pin_valid = true
  while pin_valid do
    print "Enter your 4 digit PIN : "
    pin = STDIN.noecho(&:gets).chomp.to_i
    puts
     if pin.digits.count == 4
       pin_valid = false
      if (0001..2000).include?(pin)
        choice = true
        while choice do
            print "The transaction will incur a fee of $2. Do you still want to continue (Y/N)? "
            answer = gets.chomp.capitalize
            puts
            if answer == "Y"
              choice = false
            elsif answer == "N"
              puts "Thank you for banking with us. Have a nice day! "
              puts
              exit
            else
              puts "Please enter correct choice!"
              puts
            end
          end
      end
    else
      puts "Please enter a valid PIN "
      puts
    end
  end

  $balance = 1000
  selection = "Y"
  option = 1
  while selection == "Y" do
      option = true
      while option do
        puts
        puts "What would you like to do today?  "
        puts
        puts "1. Withdraw Cash"
        puts "2. Deposit Cash"
        puts "3. Check Balance"
        puts "4. Get Mini Account Statement"
        puts "5. Exit"
        puts
        print "Please enter your choice (1, 2, 3, 4 or 5) : "
        option = gets.to_i
        puts
        case option
        when 1
          withdrawl
          option = false
        when 2
          deposit
          option = false
        when 3
          check_balance
          option = false
        when 4
          account_statement
          option = false
        when 5

          abort("Thank you for banking with us. Have a nice day!!")
          puts
        else
          puts "Invalid choice. Please enter correct choice!"
          puts
        end
      end
      transaction = true
      while transaction do
        print "Would you like to make another transaction? (Y/N) "
        selection = gets.chomp.capitalize
        puts
        if selection != "Y" and selection != "N"
          puts "Invalid choice. Please enter correct choice!"
          puts
        else
          transaction = false
        end
      end
  end
  puts "Thank you for banking with us. Have a nice day!!"
  puts
end
main
