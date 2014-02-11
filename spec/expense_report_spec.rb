require_relative('../app/expense_report')
require('mock_printer')

describe ExpenseReport do
  subject { ExpenseReport.new }
  let(:printer) { MockPrinter.new }

  it 'print empty' do
    subject.print_report(printer)

    expect(printer.text).to eq("Expenses 9/12/2002\n" +
                               "\n" +
                               "Meal expenses $0.00\n" +
                               "Total $0.00")
  end


  it 'prints one dinner' do
    subject.add_expense(Expense.new(:dinner, 1678))
    subject.print_report(printer)

    expect(printer.text).to eq("Expenses 9/12/2002\n" +
                               " \tDinner\t$16.78\n" +
                               "\n" +
                               "Meal expenses $16.78\n" +
                               "Total $16.78")
  end


  it 'twoMeals' do
    subject.add_expense(Expense.new(:dinner, 1000))
    subject.add_expense(Expense.new(:breakfast, 500))
    subject.print_report(printer)

    expect(printer.text).to eq("Expenses 9/12/2002\n" +
                               " \tDinner\t$10.00\n" +
                               " \tBreakfast\t$5.00\n" +
                               "\n" +
                               "Meal expenses $15.00\n" +
                               "Total $15.00")
  end


  it 'twoMealsAndCarRental' do
    subject.add_expense(Expense.new(:dinner, 1000))
    subject.add_expense(Expense.new(:breakfast, 500))
    subject.add_expense(Expense.new(:car_rental, 50000))
    subject.print_report(printer)

    expect(printer.text).to eq("Expenses 9/12/2002\n" +
                               " \tDinner\t$10.00\n" +
                               " \tBreakfast\t$5.00\n" +
                               " \tCar Rental\t$500.00\n" +
                               "\n" +
                               "Meal expenses $15.00\n" +
                               "Total $515.00")
  end


  it 'overages' do
    subject.add_expense(Expense.new(:breakfast, 1000))
    subject.add_expense(Expense.new(:breakfast, 1001))
    subject.add_expense(Expense.new(:dinner, 5000))
    subject.add_expense(Expense.new(:dinner, 5001))
    subject.print_report(printer)

    expect(printer.text).to eq("Expenses 9/12/2002\n" +
                               " \tBreakfast\t$10.00\n" +
                               "X\tBreakfast\t$10.01\n" +
                               " \tDinner\t$50.00\n" +
                               "X\tDinner\t$50.01\n" +
                               "\n" +
                               "Meal expenses $120.02\n" +
                               "Total $120.02")
  end

end