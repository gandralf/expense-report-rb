require_relative 'expense'

class ExpenseReport
  def initialize
    @expenses = []
  end

  def print_report(printer)
    total = 0
    meal_expenses =  0

    printer.print("Expenses #{date}\n")

    @expenses.each do |expense|
      if expense.type == :breakfast || expense.type == :dinner
        meal_expenses += expense.amount
      end

      case expense.type
        when :dinner
          name = "Dinner"
        when :breakfast
          name = "Breakfast"
        when :car_rental
          name = "Car Rental"
        else
          name = "TILT"
      end
      printer.print(sprintf("%s\t%s\t$%.02f\n",
                            ((expense.type == :dinner && expense.amount > 5000) ||
                                (expense.type == :breakfast && expense.amount > 1000)) ? "X" : " ",
                            name, expense.amount / 100.0))

      total += expense.amount
    end

    printer.print(sprintf("\nMeal expenses $%.02f", meal_expenses / 100.0))
    printer.print(sprintf("\nTotal $%.02f", total / 100.0))
  end

  def add_expense(expense)
    @expenses << expense
  end

  def date
    "9/12/2002"
  end
end